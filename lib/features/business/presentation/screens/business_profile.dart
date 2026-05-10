import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tapella/core/theme/app_colors.dart';
import 'package:tapella/core/theme/app_spacing.dart';
import 'package:tapella/core/theme/app_text_styles.dart';
import 'package:tapella/core/widgets/app_bar.dart';
import 'package:tapella/core/widgets/app_scaffold.dart';
import 'package:tapella/core/widgets/bottom_navbar.dart';
import 'package:tapella/core/widgets/glass_card.dart';
import 'package:tapella/core/widgets/primary_button.dart';
import 'package:tapella/core/widgets/provider_card.dart';
import 'package:tapella/core/widgets/red_button.dart';
import 'package:tapella/core/widgets/stat_card.dart';
import 'package:tapella/core/widgets/profile_card.dart';

class BusinessProfile extends StatelessWidget {
  const BusinessProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendBody: true,
      padding: EdgeInsets.zero,
      appBar: CustomAppBar(
        leading: const Icon(Icons.menu_rounded, color: AppColors.textWhite),
        actions: const [],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/business/home');
              break;
            case 1:
              context.go('/business/requests');
              break;
            case 2:
              context.go('/business/profile');
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
            Text("Account Settings", style: AppTextStyles.profileHeader),
            SizedBox(height: 4),
            Text(
              "Manage your profile and preferences",
              style: AppTextStyles.profileSubHeader,
            ),
            SizedBox(height: 8),
            ProviderCard(
              title: "Account Status",
              subtitle: "● Active Provider",
              row1: [
                const StatCard(value: "4.9", label: "RATING"),
                const StatCard(value: "124", label: "JOBS"),

                const StatIconCard(
                  icon: Icon(Icons.verified),
                  label: "VERIFIED",
                ),
              ],
            ),

            const SizedBox(height: 24),
            Text("My Services", style: AppTextStyles.profileHeader),
            const SizedBox(height: 16),

            ProfileCard(
              name: "Saron Kiflu",
              location: "Megenagna",
              profession: "Plumbing • Expert",
              rating: 4.8,
              description: "Master of pipes, pressure, and precision",
              icon: Icons.account_circle,
              onEdit: () {},
              onDelete: () {},
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              label: "New Listing",
              height: 56,
              width: 277,
              fill: AppColors.primaryBlue,
              onPressed: () => context.go("/business/new-listing"),
            ),
            const SizedBox(height: 16),
            _ProfileMenuCard(
              icon: Icons.person_outline,
              title: 'Personal Information',
              subtitle: 'Name, email, and bio',
              onTap: () => context.go('/business/profile-edit'),
            ),
            const SizedBox(height: AppSpacing.lg),
            _ProfileMenuCard(
              icon: Icons.bookmark_border,
              title: 'Saved Services',
              subtitle: 'Your favorite services',
              onTap: () => context.go('/business/home'),
            ),
            const SizedBox(height: AppSpacing.lg),
            _ProfileMenuCard(
              icon: Icons.help_outline,
              title: 'Help',
              subtitle: 'Support tickets & documentation',
              onTap: () {},
            ),

            const SizedBox(height: AppSpacing.xxl),

            PrimaryButton(
              label: "Log Out",
              height: 56,
              width: 277,
              fill: AppColors.primaryBlue,
              onPressed: () => context.go("/business/login"),
            ),

            const SizedBox(height: AppSpacing.lg),
            RedButton(
              label: "Delete Account",
              height: 56,
              width: 277,
              onPressed: () => {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Account Deleted Successfully!')),
                ),
                context.go("/business/login"),
              },
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _ProfileMenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileMenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primaryTint.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: AppColors.primaryTint, size: 22),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.cardTitle),
                  const SizedBox(height: 4),
                  Text(subtitle, style: AppTextStyles.cardSub),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary.withValues(alpha: 0.8),
            ),
          ],
        ),
      ),
    );
  }
}
