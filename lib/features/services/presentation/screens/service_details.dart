import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tapella/core/theme/app_colors.dart';
import 'package:tapella/core/theme/app_text_styles.dart';
import 'package:tapella/core/widgets/app_bar.dart';
import 'package:tapella/core/widgets/bottom_navbar.dart';
import 'package:tapella/core/widgets/glass_card.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../presentation/providers/listings_provider.dart';
import '../../../bookings/presentation/providers/bookings_provider.dart';
import '../../../reviews/presentation/providers/reviews_provider.dart';

class ServiceDetail extends ConsumerStatefulWidget {
  final String listingId;

  const ServiceDetail({super.key, required this.listingId});

  @override
  ConsumerState<ServiceDetail> createState() => _ServiceDetailState();
}

class _ServiceDetailState extends ConsumerState<ServiceDetail> {
  int _currentIndex = 0;
  final _day = TextEditingController();
  final _month = TextEditingController();
  final _year = TextEditingController();
  final _reviewComment = TextEditingController();
  int _reviewRating = 5;
  bool _submittingReview = false;

  @override
  void dispose() {
    _day.dispose();
    _month.dispose();
    _year.dispose();
    _reviewComment.dispose();
    super.dispose();
  }

  Future<void> _submitReview(String bookingId) async {
    setState(() => _submittingReview = true);
    try {
      await ref.read(submitReviewProvider).submit(
            bookingId: bookingId,
            rating: _reviewRating,
            comment: _reviewComment.text.trim(),
          );
      ref.invalidate(listingReviewsProvider(widget.listingId));
      ref.invalidate(listingDetailProvider(widget.listingId));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Review submitted. Thank you!')),
        );
        _reviewComment.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      if (mounted) setState(() => _submittingReview = false);
    }
  }

  Future<void> _book() async {
    final scheduled = '${_year.text}-${_month.text.padLeft(2, '0')}-${_day.text.padLeft(2, '0')}';
    try {
      await ref.read(bookingActionsProvider).book(
            listingId: widget.listingId,
            scheduledDate: scheduled,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.backgroundAlt,
            content: Text(
              'Service booked successfully!',
              style: TextStyle(color: AppColors.textPrimary),
            ),
          ),
        );
        context.go('/client/requests');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final listingAsync = ref.watch(listingDetailProvider(widget.listingId));
    final reviewsAsync = ref.watch(listingReviewsProvider(widget.listingId));
    final bookingsAsync = ref.watch(customerBookingsProvider);

    return AppScaffold(
      extendBody: true,
      appBar: CustomAppBar(
        onMenuPressed: () => context.pop(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: IconButton(
              onPressed: () => context.go('/client/profile'),
              icon: const Icon(Icons.account_circle, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
      body: listingAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e', style: const TextStyle(color: Colors.white))),
        data: (result) {
          final listing = result.data;
          String? reviewBookingId;
          for (final b in bookingsAsync.valueOrNull ?? []) {
            if (b.listingId == widget.listingId && b.status == 'completed') {
              reviewBookingId = b.id;
              break;
            }
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.iconBorder,
                                    width: 4.0,
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.person,
                                    color: AppColors.profileIcon,
                                    size: 100,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xl),
                            Text(listing.providerName, style: AppTextStyles.providerName),
                            Text(listing.title, style: AppTextStyles.providerLevel),
                            if (result.isStale)
                              const Text(
                                'Offline data',
                                style: TextStyle(color: Colors.amber, fontSize: 12),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      Text('About the service', style: AppTextStyles.servicesTitle),
                      const SizedBox(height: 8),
                      Text(listing.description, style: AppTextStyles.aboutDetail),
                      const SizedBox(height: AppSpacing.xl),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Customer Reviews', style: AppTextStyles.servicesM),
                          Text('★ ${listing.ratingAvg.toStringAsFixed(1)}'),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      reviewsAsync.when(
                        loading: () => const CircularProgressIndicator(),
                        error: (_, _) => const SizedBox.shrink(),
                        data: (reviews) => Column(
                          children: reviews.take(3).map((r) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: _buildReviewCard(
                                r.customerName,
                                r.comment,
                                r.rating,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      if (reviewBookingId != null) ...[
                        const SizedBox(height: 24),
                        Text('Leave a Review', style: AppTextStyles.servicesM),
                        const SizedBox(height: 8),
                        Row(
                          children: List.generate(5, (i) {
                            return IconButton(
                              onPressed: () => setState(() => _reviewRating = i + 1),
                              icon: Icon(
                                Icons.star,
                                color: i < _reviewRating ? Colors.amber : Colors.grey,
                              ),
                            );
                          }),
                        ),
                        TextField(
                          controller: _reviewComment,
                          maxLines: 3,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Share your experience...',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Color(0xFF151E3D),
                            border: OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _submittingReview
                              ? null
                              : () => _submitReview(reviewBookingId!),
                          child: Text(_submittingReview ? 'Submitting...' : 'Submit Review'),
                        ),
                      ],
                      const SizedBox(height: 24),
                      const Text(
                        'Date',
                        style: TextStyle(
                          color: AppColors.servicesTitle,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Choose service date',
                        style: TextStyle(color: AppColors.navBorder, fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildDateInput('DD', _day),
                          const SizedBox(width: 8),
                          _buildDateInput('MM', _month),
                          const SizedBox(width: 8),
                          _buildDateInput('YYYY', _year, width: 80),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 32,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: _book,
                            child: const Text(
                              'Book Now',
                              style: TextStyle(
                                color: AppColors.pillToggleSelected,
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          if (listing.phone.isNotEmpty)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.callActive.withValues(alpha: 0.2),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 32,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {},
                              child: const Icon(
                                Icons.call,
                                color: AppColors.callIcon,
                                size: 20,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildReviewCard(String name, String review, int stars) {
    return GlassCard(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.account_circle, color: Colors.white, size: 40),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: AppColors.reviewName,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: List.generate(stars, (index) {
                      return const Icon(Icons.star, color: Colors.amber, size: 12);
                    }),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateInput(String hint, TextEditingController controller, {double width = 75}) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xFF151E3D),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: const TextStyle(color: AppColors.navBorder),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.navBorder),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
