import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tapella/core/theme/app_colors.dart';
import 'package:tapella/core/theme/app_spacing.dart';
import 'package:tapella/core/theme/app_text_styles.dart';
import 'package:tapella/core/widgets/app_bar.dart';
import 'package:tapella/core/widgets/app_scaffold.dart';
import 'package:tapella/core/widgets/bottom_navbar.dart';
import 'package:tapella/core/widgets/primary_button.dart';
import 'package:tapella/core/widgets/red_button.dart';
import 'package:tapella/core/widgets/text_field.dart';

class ClientProfileEdit extends StatelessWidget {
  const ClientProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendBody: true,
      padding: EdgeInsets.zero,
      appBar: CustomAppBar(
        leading: const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.lg),
            child: GestureDetector(
              onTap: () => context.go('/client/profile'),
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 18,
                  color: AppColors.profileIcon,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/client/home');
              break;
            case 1:
              context.go('/client/requests');
              break;
            case 2:
              context.go('/client/profile');
              break;
          }
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.md),

            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE9DFFF),
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    size: 60,
                    color: Color(0xFF6B4BAF),
                  ),
                ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.background, width: 2),
                  ),
                  child: const Icon(Icons.edit, size: 14, color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.lg),

            Text('Bekelle Mola', style: AppTextStyles.profileName),
            const SizedBox(height: 4),
            Text('PREMIUM MEMBER', style: AppTextStyles.profileType),

            const SizedBox(height: AppSpacing.xl),

            /// FORM FIELDS
            const AppTextField(label: 'FULL NAME', hintText: 'Name'),
            const SizedBox(height: AppSpacing.lg),
            const AppTextField(
              label: 'EMAIL ADDRESS',
              hintText: 'test@example.com',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: AppSpacing.lg),
            const AppTextField(
              label: 'PHONE NUMBER',
              hintText: '+251900000000',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: AppSpacing.lg),
            const AppTextField(label: 'LOCATION', hintText: 'Piassa'),

            const SizedBox(height: AppSpacing.xxl),

            PrimaryButton(
              label: "Save Changes",
              height: 56,
              width: 277,
              fill: AppColors.primaryBlue,
            ),

            const SizedBox(height: AppSpacing.lg),

            RedButton(label: "Delete Account", height: 56, width: 277),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
