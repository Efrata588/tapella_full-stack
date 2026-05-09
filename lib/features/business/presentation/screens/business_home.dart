import 'package:flutter/material.dart';
import 'package:tapella/core/theme/app_colors.dart';
import 'package:tapella/core/theme/app_text_styles.dart';
import 'package:tapella/core/widgets/app_bar.dart';
import 'package:tapella/core/widgets/app_scaffold.dart';
import 'package:tapella/core/widgets/bottom_navbar.dart';
import 'package:tapella/core/widgets/glass_card.dart';
import 'package:go_router/go_router.dart';
import 'package:tapella/core/theme/app_spacing.dart';

class BusinessHome extends StatefulWidget {
  const BusinessHome({super.key});

  @override
  State<BusinessHome> createState() => _BusinessHomeState();
}

class _BusinessHomeState extends State<BusinessHome> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: CustomAppBar(
        onMenuPressed: () => context.go("/business/login"),
        leading: const Icon(Icons.menu),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: IconButton(
              onPressed: () => context.go("/business/login"),
              icon: Icon(Icons.account_circle, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          GlassCard(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'ACCOUNT STATUS',
                  style: AppTextStyles.labelSm.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          // About Section
          Text(
            'Jobs',
            style: AppTextStyles.servicesTitle,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 8),

          CustomBottomNavBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
          ),
        ],
      ),
    );
  }
}
