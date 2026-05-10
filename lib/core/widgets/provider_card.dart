import 'package:flutter/material.dart';
import 'package:tapella/core/theme/app_text_styles.dart';
import 'package:tapella/core/widgets/glass_card.dart';

class ProviderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<GlassCard>? row1;
  final List<GlassCard>? row2;

  const ProviderCard({
    Key? key,
    required this.title,
    required this.subtitle,
    this.row1,
    this.row2,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text(title, style: AppTextStyles.providerCardTitle),
          Text(subtitle, style: AppTextStyles.providerCardSub),
          if (row1 != null) ...row1!,
          if (row2 != null) ...row2!,
        ],
      ),
    );
  }
}
