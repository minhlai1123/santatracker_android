import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'christmas_typography.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.christmasRed,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      fontFamily: ChristmasTypography.fontFamilyBody,
      fontFamilyFallback: ChristmasTypography.fallbackFonts,
      textTheme: ChristmasTypography.buildTextTheme(),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.christmasRed,
        primary: AppColors.christmasRed,
        secondary: AppColors.pineGreen,
        tertiary: AppColors.warmGold,
        surface: AppColors.surfaceLight,
        brightness: Brightness.light,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: ChristmasTypography.titleLarge,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.surfaceLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          side: BorderSide(color: AppColors.cardBorder, width: 1),
        ),
      ),
    );
  }
}
