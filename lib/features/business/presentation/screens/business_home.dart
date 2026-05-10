import 'package:flutter/material.dart';
import 'package:tapella/core/theme/app_text_styles.dart';
import 'package:tapella/core/widgets/app_bar.dart';
import 'package:tapella/core/widgets/app_scaffold.dart';
import 'package:tapella/core/widgets/bottom_navbar.dart';
import 'package:go_router/go_router.dart';
import 'package:tapella/core/theme/app_spacing.dart';
import 'package:tapella/core/widgets/provider_stats.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProviderStats(
              title: 'ACCOUNT STATUS',
              userStatuses: [
                UserStatus(label: 'Active Provider', color: Colors.green),
              ],
              gridItems: [
                StatGridItem(icon: Icons.star, value: '4.9', label: 'RATING'),
                StatGridItem(icon: Icons.work, value: '120', label: 'JOBS'),
                StatGridItem(icon: Icons.person, value: '50', label: 'CLIENTS'),
                StatGridItem(
                  icon: Icons.money,
                  value: 'ETB 3500',
                  label: 'EARNINGS',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Jobs Section
            Text(
              'Jobs',
              style: AppTextStyles.servicesTitle,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8),

            //filter chips
            // Row(
            //   children: [
            //     _buildCategoryChip("ALL SERVICES", isSelected: true),

            //     _buildCategoryChip("PLUMBING"),

            //     _buildCategoryChip("ELECTRICIAN"),
            //   ],
            // ),
            CustomBottomNavBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
            ),
          ],
        ),
      ),
    );
  }
}
