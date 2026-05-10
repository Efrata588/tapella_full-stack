import 'package:flutter/material.dart';
import 'package:tapella/core/theme/app_colors.dart';
import 'package:tapella/core/theme/app_text_styles.dart';

class RedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool expand;
  final int height;
  final int width;

  const RedButton({
    super.key,
    required this.label,
    required this.height,
    required this.width,
    this.onPressed,
    this.expand = true,
  });

  @override
  Widget build(BuildContext context) {
    // final isDisabled = isLoading || onPressed == null;
    // final background = fill;
    final borderColor = AppColors.error;

    final button = SizedBox(
      height: height.toDouble(),
      // width: width.toDouble(),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: borderColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            customBorder: const StadiumBorder(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: SizedBox(
                    child: Row(
                      key: const ValueKey('content'),
                      mainAxisSize: MainAxisSize.min,
                      children: [Text(label, style: AppTextStyles.redButton)],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return button;
  }
}
