import 'package:flutter/widgets.dart';
import 'package:tapella/core/theme/app_colors.dart';
import 'package:tapella/core/theme/app_text_styles.dart';

typedef ToggleChanged = void Function(int index);

class TogglePill extends StatelessWidget {
  final String leftLabel;
  final String rightLabel;
  final int selectedIndex;
  final ToggleChanged onChanged;

  const TogglePill({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    required this.selectedIndex,
    required this.onChanged,
  }) : assert(selectedIndex == 0 || selectedIndex == 1);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final segmentWidth = width / 2;

        return Container(
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(color: AppColors.surfaceBorder),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.all(6),
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  alignment: selectedIndex == 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    width: segmentWidth,
                    height: 46,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withValues(alpha: 1),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onChanged(0),
                        behavior: HitTestBehavior.opaque,
                        child: Center(
                          child: Text(
                            leftLabel,
                            style: AppTextStyles.labelMd.copyWith(
                              color: selectedIndex == 0
                                  ? AppColors.pillToggleSelected
                                  : AppColors.pillToggleInactive,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onChanged(1),
                        behavior: HitTestBehavior.opaque,
                        child: Center(
                          child: Text(
                            rightLabel,
                            style: AppTextStyles.labelMd.copyWith(
                              color: selectedIndex == 1
                                  ? AppColors.pillToggleSelected
                                  : AppColors.pillToggleInactive,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
