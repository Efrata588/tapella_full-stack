import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tapella/core/widgets/app_scaffold.dart';
import 'package:tapella/core/widgets/glass_card.dart';
import 'package:tapella/core/widgets/primary_button.dart';
import 'package:tapella/core/widgets/secondary_button.dart';
import 'package:tapella/core/widgets/text_field.dart';
import 'package:tapella/core/widgets/toggle_pill.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class BusinessLoginScreen extends StatelessWidget {
  const BusinessLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              'Welcome to Tapella',
              style: AppTextStyles.displayLg.copyWith(
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'List. Work. Earn.',
              style: AppTextStyles.titleSm.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Accept local jobs on your schedule and grow your business.',
              style: AppTextStyles.bodySm.copyWith(color: AppColors.textMuted),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            GlassCard(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TogglePill(
                    leftLabel: 'Customer',
                    rightLabel: 'Business',
                    selectedIndex: 1,
                    onChanged: (index) {
                      if (index == 0) {
                        context.go('/client/login');
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  const AppTextField(
                    label: 'EMAIL',
                    hintText: 'business@email.com',
                    prefixIcon: Icons.mail_outline,
                  ),
                  const SizedBox(height: 24),
                  const AppTextField(
                    label: 'PASSWORD',
                    hintText: '••••••••',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                  ),
                  const SizedBox(height: 40),
                  PrimaryButton(
                    width: 277,
                    height: 56,
                    fill: AppColors.primaryBlue,
                    label: 'Login',
                    onPressed: () => context.go('/business/home'),
                  ),
                  const SizedBox(height: 16),
                  SecondaryButton(
                    label: 'Sign Up',
                    onPressed: () => context.go('/business/profile-edit'),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      child: const Text("Forgot Password"),
                      onPressed: () => context.go('/business/forgot-password'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
