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

class ClientLoginScreen extends StatelessWidget {
  const ClientLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              'Welcome to Tapella.',
              style: AppTextStyles.displayLg.copyWith(
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
              style: AppTextStyles.bodySm.copyWith(
                color: AppColors.textSecondary,
              ),
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
                    selectedIndex: 0,
                    onChanged: (index) {
                      if (index == 1) {
                        context.go('/business/login');
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  const AppTextField(
                    label: 'EMAIL',
                    hintText: 'name@email.com',
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
                    label: 'Login',
                    onPressed: () => context.go('/client/home'),
                    // isLoading: true,
                    width: 277,
                    height: 56,
                    fill: AppColors.primaryBlue,
                  ),
                  const SizedBox(height: 16),
                  SecondaryButton(
                    label: 'Sign Up',
                    onPressed: () => context.go('/client/signup'),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () => context.go('/client/forgot-password'),
                      child: Text(
                        'Forgot password?',
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.primaryTint,
                        ),
                      ),
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
