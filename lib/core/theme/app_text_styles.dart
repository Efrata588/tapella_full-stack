import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static final TextStyle displayLg = GoogleFonts.manrope(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
  static final TextStyle appBarTitle = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.appBarText,
  );

  static final TextStyle providerCardTitle = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static final TextStyle providerCardSub = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.success,
  );

  static final TextStyle displayLgBold = GoogleFonts.manrope(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static final TextStyle displayLgInter = GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static final TextStyle titleLg = GoogleFonts.manrope(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static final TextStyle servicesTitle = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.servicesTitle,
  );

  static final TextStyle titleMd = GoogleFonts.manrope(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static final TextStyle titleSm = GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w100,
    color: AppColors.textPrimary,
  );

  static final TextStyle bodyLg = GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );
  static final TextStyle cardTitle = GoogleFonts.manrope(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );
  static final TextStyle cardSub = GoogleFonts.manrope(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.pillToggleInactive,
  );

  static final TextStyle bodyMd = GoogleFonts.manrope(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static final TextStyle bodySm = GoogleFonts.manrope(
    fontSize: 13,
    fontWeight: FontWeight.w300,
    color: AppColors.textSecondary,
  );

  static final TextStyle labelMd = GoogleFonts.manrope(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );
  static final TextStyle profileType = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.pillToggleInactive,
  );

  static final TextStyle labelSm = GoogleFonts.manrope(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static final TextStyle button = GoogleFonts.manrope(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
  static final TextStyle redButton = GoogleFonts.manrope(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.error,
  );

  static final TextStyle providerName = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
  );
  static final TextStyle profileName = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.textWhite,
  );
  static final TextStyle providerLevel = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static final TextStyle aboutDetail = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w100,
    color: AppColors.textSecondary,
    height: 26 / 16,
  );

  static final TextStyle servicesM = TextStyle(
    color: AppColors.servicesTitle,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle notReady = GoogleFonts.manrope(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.notReady,
  );

  static final TextStyle providerCard = GoogleFonts.manrope(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.navBorder,
  );
  static final TextTheme textTheme = TextTheme(
    displayLarge: displayLgInter,
    titleLarge: titleLg,
    titleMedium: titleMd,
    titleSmall: titleSm,
    bodyLarge: bodyLg,
    bodyMedium: bodyMd,
    bodySmall: bodySm,
    labelLarge: button,
    labelMedium: labelMd,
    labelSmall: labelSm,
  );
}
