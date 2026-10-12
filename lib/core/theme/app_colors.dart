import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // Primary festive palette
  static const Color christmasRed = Color(0xFFC41E3A); // Deep Cardinal Red
  static const Color pineGreen = Color(0xFF1B4D3E); // Deep Forest Pine
  static const Color warmGold = Color(0xFFD4AF37); // Elegant Holiday Gold
  static const Color snowWhite = Color(0xFFFFFFFF);
  static const Color softSnow = Color(0xFFF8FAFC);

  // Background and surfaces
  static const Color backgroundLight = Color(0xFFF9FBFD);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFE2E8F0);

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

  static const LinearGradient badgeGradient = LinearGradient(
    colors: [Color(0xFFFEF2F2), Color(0xFFFFFBEB)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
