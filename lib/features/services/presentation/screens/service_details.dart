import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tapella/core/theme/app_colors.dart';
import 'package:tapella/core/theme/app_text_styles.dart';
import 'package:tapella/core/widgets/app_bar.dart';
import 'package:tapella/core/widgets/bottom_navbar.dart';
import 'package:tapella/core/widgets/glass_card.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_scaffold.dart';

class ServiceDetail extends StatefulWidget {
  const ServiceDetail({super.key});

  @override
  State<ServiceDetail> createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetail> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendBody: true,
      appBar: CustomAppBar(
        onMenuPressed: () => context.go("/service/detail/alt-1"),
        leading: const Icon(Icons.menu),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: IconButton(
              onPressed: () => context.go("/client/login"),
              icon: Icon(Icons.account_circle, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Provider Header
                  Center(
                    child: Column(
                      children: [
                        // to give the icon a border since the iconbutton doesnt take border
                        Center(
                          child: Container(
                            width: 150, // Adjust overall size as needed
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              // This adds the dark border ring seen around the white circle
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
                        Text('Saron Kiflu', style: AppTextStyles.providerName),
                        Text(
                          'PREMIUM PROVIDER',
                          style: AppTextStyles.providerLevel,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // About Section
                  Text('About the service', style: AppTextStyles.servicesTitle),
                  const SizedBox(height: 8),
                  Text(
                    'Reliable housekeeping provider offering cleaning, laundry, and home organization services. Focused on keeping your space neat, fresh, and comfortable.',
                    style: AppTextStyles.aboutDetail,
                  ),
                  const SizedBox(height: AppSpacing.xl),

                  // Reviews Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Customer Reviews', style: AppTextStyles.servicesM),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'View all',
                          style: TextStyle(
                            color: AppColors.labelTextPrimary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.xl),

                  // Review Cards
                  _buildReviewCard(
                    'Elroi T',
                    'Reliable housekeeping provider offering cleaning, laundry, and home organization services. Focused on keeping your space neat, fresh, and comfortable.',
                    5,
                  ),
                  const SizedBox(height: 24),
                  _buildReviewCard(
                    'Efrata E',
                    'Reliable housekeeping provider offering cleaning, laundry, and home organization services. Focused on keeping your space neat, fresh, and comfortable.',
                    3,
                  ),
                  const SizedBox(height: 24),
                  _buildReviewCard(
                    'Naomi M',
                    'Reliable housekeeping provider offering cleaning, laundry, and home organization services. Focused on keeping your space neat, fresh, and comfortable.',
                    5,
                  ),

                  const SizedBox(height: 24),
                  // Date Picker Section
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
                      _buildDateInput('DD'),
                      const SizedBox(width: 8),
                      _buildDateInput('MM'),
                      const SizedBox(width: 8),
                      _buildDateInput('YYYY', width: 80),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Action Buttons
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
                        onPressed: () {
                          // context.go("/business/book/alt-1");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: AppColors.backgroundAlt,
                              content: Text(
                                "Service booked successfully!",
                                style: TextStyle(color: AppColors.textPrimary),
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Book Now',
                          style: TextStyle(
                            color: AppColors.pillToggleSelected,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.callActive.withValues(
                            alpha: 0.2,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 32,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {},
                        child: Icon(
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
              Icon(Icons.account_circle, color: Colors.white, size: 40),
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
                      return Icon(Icons.star, color: Colors.amber, size: 12);
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

  Widget _buildDateInput(String hint, {double width = 75}) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xFF151E3D),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
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
