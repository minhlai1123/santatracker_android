import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Christmas Typography System
///
/// Group A — Decorative Titles (Christmas Display): [fontFamilyDisplay] = 'Lobster'
///   For app name, main screen headings, featured section titles, and Advent story names.
/// Group B — Interface Headings (UI Titles / Buttons / Badges): [fontFamilyUI] = 'Fredoka'
///   For buttons, feature cards, location names, mini-game titles, and subheadings.
/// Group C — Body Text & Numbers (Body / Numbers / Stats): [fontFamilyBody] = 'Nunito'
///   For countdown timer, game instructions, story content, unlock statuses, and route stats.
class ChristmasTypography {
  const ChristmasTypography._();

  static const String fontFamilyDisplay = 'Lobster';
  static const String fontFamilyUI = 'Fredoka';
  static const String fontFamilyBody = 'Nunito';

  static const List<String> fallbackFonts = ['Nunito', 'Roboto', 'sans-serif'];

  // ---------------------------------------------------------------------------
  // Group A — Decorative Titles (Christmas Display)
  // ---------------------------------------------------------------------------
  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontFamilyFallback: fallbackFonts,
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
    height: 1.25,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontFamilyFallback: fallbackFonts,
    fontSize: 26,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: 0.4,
    height: 1.25,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: fontFamilyDisplay,
    fontFamilyFallback: fallbackFonts,
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: 0.3,
    height: 1.25,
  );

  // ---------------------------------------------------------------------------
  // Group B — Interface Headings, Cards & Buttons (UI Titles)
  // ---------------------------------------------------------------------------
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamilyUI,
    fontFamilyFallback: fallbackFonts,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 0.3,
    height: 1.3,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamilyUI,
    fontFamilyFallback: fallbackFonts,
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 0.2,
    height: 1.3,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamilyUI,
    fontFamilyFallback: fallbackFonts,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.2,
    height: 1.3,
  );

  static const TextStyle buttonLabel = TextStyle(
    fontFamily: fontFamilyUI,
    fontFamilyFallback: fallbackFonts,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
  );

  static const TextStyle badgeLabel = TextStyle(
    fontFamily: fontFamilyUI,
    fontFamilyFallback: fallbackFonts,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  // ---------------------------------------------------------------------------
  // Group C — Body Text & Data (Body, Numbers, Story Text)
  // ---------------------------------------------------------------------------
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamilyBody,
    fontFamilyFallback: fallbackFonts,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.6,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamilyBody,
    fontFamilyFallback: fallbackFonts,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamilyBody,
    fontFamilyFallback: fallbackFonts,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static const TextStyle countdownDigit = TextStyle(
    fontFamily: fontFamilyBody,
    fontFamilyFallback: fallbackFonts,
    fontSize: 28,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.5,
    height: 1.1,
  );

  static const TextStyle statValue = TextStyle(
    fontFamily: fontFamilyBody,
    fontFamilyFallback: fallbackFonts,
    fontSize: 18,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.3,
  );

  static const TextStyle displayTitle = displayMedium;
  static const TextStyle displaySubtitle = displaySmall;
  static const TextStyle cardTitle = titleSmall;
  static const TextStyle cardSubtitle = bodySmall;
  static const TextStyle statLabel = badgeLabel;

  /// Builds a complete Material 3 [TextTheme] adhering to the Christmas Typography System.
  static TextTheme buildTextTheme() {
    return const TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: displaySmall,
      headlineMedium: titleLarge,
      headlineSmall: titleMedium,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: buttonLabel,
      labelMedium: badgeLabel,
      labelSmall: bodySmall,
    );
  }
}
