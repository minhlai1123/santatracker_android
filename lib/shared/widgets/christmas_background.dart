import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'snowfall_overlay.dart';

/// Multi-layered Christmas Winter Wonderland Background
///
/// Provides deep visual atmosphere:
/// - Midnight starry sky with soft aurora borealis glow
/// - Distant snow-capped mountain silhouettes
/// - Dense pine tree ridges in the middle ground
/// - Layered snowdrifts and gentle falling snow
class ChristmasBackground extends StatelessWidget {
  final Widget child;
  final bool showSnowfall;
  final bool isDarkTheme;

  const ChristmasBackground({
    super.key,
    required this.child,
    this.showSnowfall = true,
    this.isDarkTheme = true,
  });

  @override
  Widget build(BuildContext context) {
    final stack = Stack(
      children: [
        // Base Sky Gradient
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: isDarkTheme
                  ? AppColors.nightSkyGradient
                  : const LinearGradient(
                      colors: [
                        Color(0xFFE8F3FA),
                        Color(0xFFF1F7FD),
                        Color(0xFFFFFFFF),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
            ),
          ),
        ),

        // Illustrated Scenery Backdrop
        Positioned.fill(
          child: RepaintBoundary(
            child: CustomPaint(
              painter: _WinterSceneryPainter(isDark: isDarkTheme),
            ),
          ),
        ),

        // Foreground Interactive Content
        Positioned.fill(child: child),
      ],
    );

    if (showSnowfall) {
      return SnowfallOverlay(numberOfSnowflakes: 32, child: stack);
    }

    return stack;
  }
}

class _WinterSceneryPainter extends CustomPainter {
  final bool isDark;

  const _WinterSceneryPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    if (isDark) {
      // 1. Aurora Borealis Ribbon Glow
      final auroraPath = Path()
        ..moveTo(0, h * 0.12)
        ..quadraticBezierTo(w * 0.35, h * 0.06, w * 0.7, h * 0.16)
        ..quadraticBezierTo(w * 0.88, h * 0.22, w, h * 0.18)
        ..lineTo(w, 0)
        ..lineTo(0, 0)
        ..close();

      final auroraPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            AppColors.auroraTeal.withAlpha(0),
            AppColors.auroraTeal.withAlpha(35),
            AppColors.auroraEmerald.withAlpha(20),
            Colors.transparent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, 0, w, h * 0.3));

      canvas.drawPath(auroraPath, auroraPaint);

      // 2. Twinkling Stars in Night Sky
      final starPaint = Paint()..color = Colors.white;
      final starPositions = [
        Offset(w * 0.12, h * 0.05),
        Offset(w * 0.28, h * 0.08),
        Offset(w * 0.45, h * 0.03),
        Offset(w * 0.65, h * 0.07),
        Offset(w * 0.82, h * 0.04),
        Offset(w * 0.92, h * 0.10),
        Offset(w * 0.20, h * 0.15),
        Offset(w * 0.55, h * 0.14),
        Offset(w * 0.75, h * 0.19),
        Offset(w * 0.08, h * 0.22),
        Offset(w * 0.38, h * 0.25),
        Offset(w * 0.88, h * 0.28),
      ];

      for (int i = 0; i < starPositions.length; i++) {
        final pos = starPositions[i];
        final r = (i % 3 == 0) ? 1.8 : 1.2;
        starPaint.color = Colors.white.withAlpha(140 + (i * 9) % 115);
        canvas.drawCircle(pos, r, starPaint);

        // 4-point twinkle sparkle on a couple larger stars
        if (i % 4 == 0) {
          final sparklePaint = Paint()
            ..color = AppColors.warmGold.withAlpha(160)
            ..strokeWidth = 0.8;
          canvas.drawLine(
            Offset(pos.dx - 3.5, pos.dy),
            Offset(pos.dx + 3.5, pos.dy),
            sparklePaint,
          );
          canvas.drawLine(
            Offset(pos.dx, pos.dy - 3.5),
            Offset(pos.dx, pos.dy + 3.5),
            sparklePaint,
          );
        }
      }
    }

    // 3. Distant Mountains (Soft Silhouettes)
    final mountainPath = Path()
      ..moveTo(0, h * 0.45)
      ..lineTo(w * 0.22, h * 0.36)
      ..lineTo(w * 0.48, h * 0.42)
      ..lineTo(w * 0.72, h * 0.34)
      ..lineTo(w * 0.90, h * 0.40)
      ..lineTo(w, h * 0.37)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    final mountainPaint = Paint()
      ..color = isDark
          ? const Color(0xFF142744).withAlpha(160)
          : const Color(0xFFD6E6F2).withAlpha(180);
    canvas.drawPath(mountainPath, mountainPaint);

    // 4. Distant Pine Ridge Silhouette
    final ridgeY = h * 0.46;
    final treePaint = Paint()
      ..color = isDark
          ? const Color(0xFF0F223B).withAlpha(190)
          : const Color(0xFFC3D9E9).withAlpha(200);

    for (double x = 0; x <= w + 16; x += 14) {
      final treeHeight = 16.0 + ((x * 7) % 12);
      final treePath = Path()
        ..moveTo(x, ridgeY)
        ..lineTo(x + 7, ridgeY - treeHeight)
        ..lineTo(x + 14, ridgeY)
        ..close();
      canvas.drawPath(treePath, treePaint);
    }

    // 5. Soft Rolling Snowbanks at base
    final snowBankPath = Path()
      ..moveTo(0, h * 0.55)
      ..quadraticBezierTo(w * 0.3, h * 0.52, w * 0.65, h * 0.58)
      ..quadraticBezierTo(w * 0.85, h * 0.62, w, h * 0.59)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    final snowBankPaint = Paint()
      ..color = isDark
          ? const Color(0xFF0B1728).withAlpha(230)
          : const Color(0xFFEDF4FA);
    canvas.drawPath(snowBankPath, snowBankPaint);
  }

  @override
  bool shouldRepaint(covariant _WinterSceneryPainter oldDelegate) =>
      oldDelegate.isDark != isDark;
}
