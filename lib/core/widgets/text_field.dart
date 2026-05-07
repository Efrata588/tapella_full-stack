import 'package:flutter/material.dart';
import 'package:tapella/core/theme/app_colors.dart';
import 'package:tapella/core/theme/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? errorText;
  final String? helperText;
  final bool isValid;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;

  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.errorText,
    this.helperText,
    this.isValid = false,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Text(
              label!,
              style: AppTextStyles.labelMd.copyWith(
                color: AppColors.labelTextPrimary.withAlpha(70),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style: AppTextStyles.bodyLg.copyWith(color: AppColors.textPrimary),
          decoration: InputDecoration(
            isDense: false,
            contentPadding: const EdgeInsets.fromLTRB(48, 0, 18, 0),

            hintText: hintText,
            hintStyle: AppTextStyles.bodyMd.copyWith(
              color: AppColors.textMuted,
            ),
            filled: true,
            fillColor: AppColors.inputFill,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),

            // 👇 THIS IS THE SECRET
            prefixIconConstraints: const BoxConstraints(
              minHeight: 70,
              minWidth: 40,
            ),
            suffixIconConstraints: const BoxConstraints(
              minHeight: 70,
              minWidth: 40,
            ),

            prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,

            suffixIcon: suffixIcon != null
                ? IconButton(
                    onPressed: onSuffixTap,
                    icon: Icon(suffixIcon, size: 20),
                  )
                : null,

            errorText: errorText,
            helperText: helperText,
            helperStyle: AppTextStyles.bodySm.copyWith(
              color: AppColors.textMuted,
            ),
          ),
        ),
      ],
    );
  }
}
