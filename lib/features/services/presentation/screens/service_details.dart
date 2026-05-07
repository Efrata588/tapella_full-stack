import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tapella/core/theme/app_colors.dart';
import 'package:tapella/core/theme/app_text_styles.dart';
import 'package:tapella/core/widgets/app_bar.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_scaffold.dart';

class ServiceDetail extends StatelessWidget {
  const ServiceDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Provider Header
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150',
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text('Saron Kiflu', style: AppTextStyles.providerName),
                  Text('PREMIUM PROVIDER', style: AppTextStyles.providerLevel),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // About Section
            Text('About the service', style: AppTextStyles.titleLg),
            const SizedBox(height: 8),
            Text(
              'Reliable housekeeping provider offering cleaning, laundry, and home organization services. Focused on keeping your space neat, fresh, and comfortable.',
              style: AppTextStyles.aboutDetail,
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Reviews Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Customer Reviews',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View all',
                    style: TextStyle(color: Colors.white60),
                  ),
                ),
              ],
            ),

            // Review Cards
            _buildReviewCard(
              'Elroi T',
              'Reliable housekeeping provider offering cleaning, laundry, and home organization services. Focused on keeping your space neat, fresh, and comfortable.',
            ),
            _buildReviewCard(
              'Efrata E',
              'Reliable housekeeping provider offering cleaning, laundry, and home organization services. Focused on keeping your space neat, fresh, and comfortable.',
            ),
            _buildReviewCard(
              'Naomi Mesfin',
              'Reliable housekeeping provider offering cleaning, laundry, and home organization services. Focused on keeping your space neat, fresh, and comfortable.',
            ),

            const SizedBox(height: 32),
            // Date Picker Section
            const Text(
              'Date',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Choose service date',
              style: TextStyle(color: Colors.blueAccent, fontSize: 14),
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
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF89B4FA),
                    padding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 32,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A3A32),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.phone_in_talk,
                    color: Colors.greenAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(String name, String review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.glass,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 18, backgroundColor: Colors.grey),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '★★★★★',
                    style: TextStyle(color: Colors.amber, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review,
            style: const TextStyle(
              color: Colors.white70,
              fontStyle: FontStyle.italic,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateInput(String hint, {double width = 60}) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xFF151E3D),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white30),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
