import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tapella/core/widgets/app_scaffold.dart';
import 'package:tapella/core/widgets/glass_card.dart';
import 'package:tapella/core/widgets/primary_button.dart';
import 'package:tapella/core/widgets/secondary_button.dart';
import 'package:tapella/core/widgets/text_field.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class ClientSignupScreen extends StatelessWidget {
  const ClientSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              'Create Account',
              style: AppTextStyles.displayLgBold.copyWith(
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Find. Book. Done.',
              style: AppTextStyles.titleSm.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Connect with top-rated local professionals in seconds.',
              style: AppTextStyles.bodySm.copyWith(color: AppColors.textMuted),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign Up',
                    style: AppTextStyles.titleSm.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const AppTextField(
                    label: 'Full Name',
                    hintText: 'Jane Doe',
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
                  const AppTextField(
                    label: 'Email',
                    hintText: 'name@email.com',
                    prefixIcon: Icons.mail_outline,
                  ),
                  const SizedBox(height: 16),
                  const AppTextField(
                    label: 'Password',
                    hintText: '••••••••',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  const AppTextField(
                    label: 'Confirm Password',
                    hintText: '••••••••',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    label: 'Sign Up',
                    height: 56,
                    width: 277,
                    fill: AppColors.primaryBlue,
                    onPressed: () => context.go('/client/home'),
                  ),
                  const SizedBox(height: 12),
                  SecondaryButton(
                    label: 'Back to Login',
                    onPressed: () => context.go('/client/login'),
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
