import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tapella/core/widgets/app_scaffold.dart';
import 'package:tapella/core/widgets/glass_card.dart';
import 'package:tapella/core/widgets/primary_button.dart';
import 'package:tapella/core/widgets/secondary_button.dart';
import 'package:tapella/core/widgets/text_field.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class BusinessSignupScreen extends StatelessWidget {
  const BusinessSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              'Create Business Account',
              style: AppTextStyles.displayLgBold.copyWith(
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'List services, manage requests, and grow.',
              style: AppTextStyles.bodySm.copyWith(color: AppColors.textMuted),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Business Details',
                    style: AppTextStyles.titleSm.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const AppTextField(
                    label: 'Business Name',
                    hintText: 'Tapella Services',
                    prefixIcon: Icons.storefront,
                  ),
                  const SizedBox(height: 16),
                  const AppTextField(
                    label: 'Email',
                    hintText: 'business@email.com',
                    prefixIcon: Icons.mail_outline,
                  ),
                  const SizedBox(height: 16),
                  const AppTextField(
                    label: 'Phone',
                    hintText: '+251 911 000 000',
                    prefixIcon: Icons.phone_outlined,
                  ),
                  const SizedBox(height: 16),
                  const AppTextField(
                    label: 'Password',
                    hintText: '••••••••',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    width: 277,
                    height: 56,
                    fill: AppColors.primaryBlue,
                    label: 'Create Account',
                    onPressed: () => context.go('/business/home'),
                  ),
                  const SizedBox(height: 12),
                  SecondaryButton(
                    label: 'Back to Login',
                    onPressed: () => context.go('/business/login'),
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
