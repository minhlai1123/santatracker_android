import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // Primary festive palette
  static const Color christmasRed = Color(0xFFC41E3A); // Deep Cardinal Red
  static const Color pineGreen = Color(0xFF1B4D3E); // Deep Forest Pine
  static const Color evergreen = Color(0xFF153C32); // Rich Evergreen Forest
  static const Color deepBurgundy = Color(
    0xFF76263A,
  ); // Luxurious Deep Burgundy
  static const Color warmGold = Color(0xFFD4AF37); // Elegant Holiday Gold
  static const Color warmGoldAccent = Color(0xFFE8BE63); // Bright Golden Glow
  static const Color snowWhite = Color(0xFFFFFFFF);
  static const Color snowWhiteWarm = Color(0xFFFFF9F0);
  static const Color softSnow = Color(0xFFF8FAFC);

  // Background and surfaces
  static const Color backgroundLight = Color(0xFFF9FBFD);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFE2E8F0);
  static const Color cardBorderGold = Color(0xFFE8BE63);

  // Winter night sky, aurora and ice colors
  static const Color iceBlue = Color(0xFFE0F2FE);
  static const Color iceBlueMuted = Color(0xFFD9EAF5);
  static const Color iceBlueTint = Color(0xFFF0F9FF);
  static const Color midnightBlue = Color(0xFF0F172A);
  static const Color midnightBlueDeep = Color(0xFF172A46);
  static const Color deepNavy = Color(0xFF0B192C);
  static const Color nightSkyDark = Color(0xFF081226);
  static const Color auroraTeal = Color(0xFF14B8A6);
  static const Color auroraEmerald = Color(0xFF10B981);

  // Warm glowing lights & accents
  static const Color warmGlow = Color(0xFFFFD166);
  static const Color amberGold = Color(0xFFF59E0B);
  static const Color candlelight = Color(0xFFFEF3C7);
  static const Color lanternAmber = Color(0xFFFFB703);

  // Subtle festive tints for cards and badges
  static const Color redTint = Color(0xFFFFF1F2);
  static const Color greenTint = Color(0xFFF0FDF4);
  static const Color goldTint = Color(0xFFFEFCE8);

  // Text colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textMuted = Color(0xFF94A3B8);

  // Gradients
  static const LinearGradient festiveHeaderGradient = LinearGradient(
    colors: [christmasRed, Color(0xFF991B1B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient pineHeaderGradient = LinearGradient(
    colors: [pineGreen, Color(0xFF0F362A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldShimmerGradient = LinearGradient(
    colors: [Color(0xFFFFE082), warmGold, amberGold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient winterSkyGradient = LinearGradient(
    colors: [deepNavy, Color(0xFF1E293B)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient nightSkyGradient = LinearGradient(
    colors: [nightSkyDark, Color(0xFF0F2242), Color(0xFF173663)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient auroraGradient = LinearGradient(
    colors: [
      nightSkyDark,
      Color(0xFF0E323D),
      Color(0xFF13424A),
      Color(0xFF162D4D),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient badgeGradient = LinearGradient(
    colors: [Color(0xFFFEF2F2), Color(0xFFFFFBEB)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient countdownCardGradient = LinearGradient(
    colors: [Color(0xFFFFF8F8), Color(0xFFFFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroCardRedGradient = LinearGradient(
    colors: [Color(0xFF8B1E32), christmasRed],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroCardPineGradient = LinearGradient(
    colors: [evergreen, pineGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroCardNavyGradient = LinearGradient(
    colors: [Color(0xFF0B172E), Color(0xFF162A4E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
