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
import 'package:tapella/core/widgets/red_button.dart';

class ClientProfile extends StatelessWidget {
  const ClientProfile({super.key});

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

            GestureDetector(
              onTap: () => context.go('/client/profile/edit'),
              child: Container(
                width: 110,
                height: 110,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.profileCirclePurple,
                ),
                child: const Icon(
                  Icons.person_outline,
                  size: 60,
                  color: AppColors.profileIconP,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            Text('Bekelle Mola', style: AppTextStyles.profileName),
            const SizedBox(height: 4),
            Text('PREMIUM MEMBER', style: AppTextStyles.profileType),

            const SizedBox(height: AppSpacing.xl),

            _ProfileMenuCard(
              icon: Icons.person_outline,
              title: 'Personal Information',
              subtitle: 'Name, email, and bio',
              onTap: () => context.go('/client/profile/edit'),
            ),
            const SizedBox(height: AppSpacing.lg),
            _ProfileMenuCard(
              icon: Icons.bookmark_border,
              title: 'Saved Services',
              subtitle: 'Your favorite services',
              onTap: () => context.go('/client/home'),
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
              onPressed: () => context.go("/client/login"),
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
                context.go("/client/login"),
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
