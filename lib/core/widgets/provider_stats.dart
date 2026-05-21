import 'package:flutter/material.dart';
import 'glass_card.dart';

/// A single status badge shown below the card title.
class UserStatus {
  final String label;
  final Color color;

  const UserStatus({required this.label, required this.color});
}

/// Data for one cell in the stats grid.
class StatGridItem {
  /// Either an icon or a text value (e.g. "4.9", "ETB 3500").
  /// Supply [icon] OR [value] — if both are supplied, [icon] takes precedence.
  final IconData? icon;
  final String? value;

  /// Sub-label shown beneath the icon/value (e.g. "RATING", "JOBS").
  final String label;

  /// Optional override for the value text style.
  final TextStyle? valueStyle;

  const StatGridItem({
    this.icon,
    this.value,
    required this.label,
    this.valueStyle,
  }) : assert(
         icon != null || value != null,
         'Provide either icon or value for each StatGridItem',
       );
}

/// A card that displays a section [title], a list of [userStatuses] shown as
/// coloured dot + label badges, and a 2-column grid of [gridItems].
///
/// Uses [GlassCard] as the outer container.
class ProviderStats extends StatelessWidget {
  final String title;

  /// One or more status badge rows (e.g. "Active Provider").
  final List<UserStatus> userStatuses;

  /// Cells rendered in a 2-column grid below the status row.
  final List<StatGridItem> gridItems;

  const ProviderStats({
    super.key,
    required this.title,
    required this.userStatuses,
    required this.gridItems,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Title ──────────────────────────────────────────────────────────
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 10),

          // ── Status badges ──────────────────────────────────────────────────
          ...userStatuses.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: s.color,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: s.color.withValues(alpha: 0.6),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    s.label,
                    style: TextStyle(
                      color: s.color,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Grid ───────────────────────────────────────────────────────────
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: gridItems.length,
            padding: EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.3,
            ),
            itemBuilder: (context, index) {
              return _StatTile(item: gridItems[index]);
            },
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final StatGridItem item;

  const _StatTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      // padding: EdgeInsets.all(20),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (item.icon != null)
            Icon(item.icon, color: Colors.white70, size: 28)
          else
            Text(
              item.value!,
              style:
                  item.valueStyle ??
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          const SizedBox(height: 6),
          Text(
            item.label.toUpperCase(),
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
