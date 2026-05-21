import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Core background
  static const Color pillToggleSelected = Color(0xFF001A41);
  static const Color pillToggleInactive = Color(0xFFC1C6D7);
  static const Color background = Color(0xFF0B1229);
  static const Color backgroundAlt = Color(0xFF131B2E);
  static const Color surface = Color(0xFF060E20);
  static const Color surfaceDeep = Color(0xFF060E20);

  // Navbar fill
  static const Color navSurface = Color(0xFF0F172A);
  static const Color navBorder = Color(0xFF60A5FA);
  static const Color navShadow = Color(0xFFADC6FF);

  // Login Button
  static const auth = LinearGradient(
    colors: [Color(0xFFADC6FF), Color(0xFF4B8EFF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Call Button
  static const Color callActive = Color(0xFF4AE176);
  static const Color callIcon = Color(0xFF00FF48);

  // Brand
  static const Color primaryBlue = Color(0xFF4B8EFF);
  static const Color primaryTint = Color(0xFFADC6FF);

  // App Bar
  static const Color appBarText = Color(0xFFFFFFFF);
  static final LinearGradient grad = LinearGradient(
    colors: [
      Colors.white.withValues(alpha: 0),
      Colors.white.withValues(alpha: 0.1),
      Colors.white.withValues(alpha: 0),
    ],
    stops: [0.0, 0.5, 1.0],
  );

  // service detail screen colors
  static const Color profileIcon = Color(0xFF4A4A4A);
  static const Color iconBorder = Color(0xFF28334A);
  static const Color serviceDetailSurfaceDeep = Color(0xFF060E20);
  static const Color servicesTitle = Color(0xFFDCE1FF);

  // Text
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFFDAE2FD);
  static const Color textSecondary = Color(0xFFC1C6D7);
  static const Color textMuted = Color(0xFF8B90A0);

  // Profile Circle
  static const Color profileCirclePurple = Color(0xFFE9DFFF);
  static const Color profileIconP = Color(0xFF6B4BAF);

  // Input Labels
  static const Color labelTextPrimary = Color(0xFFADC6FF);
  static const Color reviewName = Color(0xFFD8E2FF);

  // Surfaces and borders
  static const Color surfaceBorder = Color(0xFF414755);
  static const Color inputFill = Color(0xFF060E20);

  // Status
  static const Color success = Color(0xFF81C784);
  static const Color successBright = Color(0xFF4AE176);
  static const Color warning = Color(0xFFFACC15);
  static const Color error = Color(0xFFFFB4AB);

  // Legacy values kept for compatibility
  static const Color backgroundTop = background;
  static const Color backgroundBottom = Color(0xFF0E1A34);
  static const Color glass = Color(0x1AFFFFFF);
  static const Color glassBorder = Color(0x33FFFFFF);
  static const Color glassDark = Color(0x14000000);
  static const Color surfaceDark = surfaceDeep;

  // client_request_card colors
  static const Color requestAvatarBackground = Colors.white24;
  static const Color requestAvatarCircle = Color.fromARGB(255, 25, 26, 36);
  static const Color requestAvatarIcon = Colors.white;
  static const Color requestAvatarShadow = Color(0xFF060E20);
  static const Color requestBoxDecorationBackground = Color(0xFF4AE176);
  static const Color requestBoxDecorationBorder = Color(0xFF1A1F31);

  // service detail screen colors
  static const Color iconColor = Color(0xFFC1C6D7);
  static const Color reaedyToCall = Color(0xFF007AFF);
  static const Color notReady = Color(0xFFFFB4AB);
}
