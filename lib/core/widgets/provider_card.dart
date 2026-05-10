import 'package:flutter/material.dart';
import 'package:tapella/core/theme/app_text_styles.dart';
import 'package:tapella/core/widgets/glass_card.dart';

class ProviderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget>? row1;
  final List<Widget>? row2;

  const ProviderCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.row1,
    this.row2,
  });

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];
    if (row1 != null) items.addAll(row1!);
    if (row2 != null) items.addAll(row2!);

    return GlassCard(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Text(title, style: AppTextStyles.providerCardTitle),
          const SizedBox(height: 8),
          Text(subtitle, style: AppTextStyles.providerCardSub),

          if (items.isNotEmpty) ...[
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.84,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) => items[index],
            ),
          ],
        ],
      ),
    );
  }
}
