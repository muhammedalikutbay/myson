import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primaryBlue = Color(0xFF007AFF);
  static const Color danger = Color(0xFFFF3B30);
  static const Color success = Color(0xFF34C759);
  static const Color neutralGray = Color(0xFF8E8E93);

  // Background Colors (Light Mode)
  static const Color background = Color(0xFFFFFFFF);
  static const Color secondaryBackground = Color(0xFFF2F2F7);
  static const Color tertiaryBackground = Color(0xFFFFFFFF);

  // Text Colors
  static const Color label = Color(0xFF000000);
  static const Color secondaryLabel = Color(0x993C3C43); // 60% opacity
  static const Color tertiaryLabel = Color(0x4D3C3C43); // 30% opacity

  // Separator
  static const Color separator = Color(0x4A3C3C43); // 29% opacity
}

class AppTypography {
  static const String fontFamily = 'SF Pro Display';
  static const String textFontFamily = 'SF Pro Text';

  static const TextStyle displayLarge = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.37,
    color: AppColors.label,
  );

  static const TextStyle headline = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.41,
    color: AppColors.label,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.normal,
    letterSpacing: -0.41,
    color: AppColors.label,
  );

  static const TextStyle footnote = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    letterSpacing: -0.08,
    color: AppColors.secondaryLabel,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
    color: AppColors.secondaryLabel,
  );
}
