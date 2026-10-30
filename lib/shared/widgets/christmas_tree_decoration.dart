import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// An illustrated Christmas Pine Tree widget drawn with Flutter [CustomPainter].
///
/// Features layered pine foliage with snow dusting, warm glowing baubles,
/// a festive tree trunk, and a glowing golden star on top.
class ChristmasTreeDecoration extends StatelessWidget {
  final double width;
  final double height;
  final bool showGlow;

  const ChristmasTreeDecoration({
    super.key,
    this.width = 84,
    this.height = 96,
    this.showGlow = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(painter: _ChristmasTreePainter(showGlow: showGlow)),
    );
  }
}

class _ChristmasTreePainter extends CustomPainter {
  final bool showGlow;

  _ChristmasTreePainter({required this.showGlow});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final centerX = w / 2;

    // 1. Optional background glow behind tree
    if (showGlow) {
      final glowPaint = Paint()
        ..shader =
            RadialGradient(
              colors: [
                AppColors.warmGlow.withAlpha(90),
                AppColors.warmGlow.withAlpha(0),
              ],
            ).createShader(
              Rect.fromCircle(
                center: Offset(centerX, h * 0.45),
                radius: w * 0.55,
              ),
            );
      canvas.drawCircle(Offset(centerX, h * 0.45), w * 0.55, glowPaint);
    }

    // 2. Trunk
    final trunkWidth = w * 0.16;
    final trunkHeight = h * 0.18;
    final trunkTop = h - trunkHeight - 4;
    final trunkRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(centerX, trunkTop + trunkHeight / 2),
        width: trunkWidth,
        height: trunkHeight,
      ),
      const Radius.circular(3),
    );
    final trunkPaint = Paint()..color = const Color(0xFF6B4226);
    canvas.drawRRect(trunkRect, trunkPaint);

    // 3. Tree Tiers (Bottom to Top)
    // Bottom Tier
    _drawTier(
      canvas: canvas,
      centerX: centerX,
      topY: h * 0.48,
      bottomY: h * 0.82,
      baseHalfWidth: w * 0.44,
      darkColor: const Color(0xFF143D31),
      lightColor: AppColors.pineGreen,
    );

    // Middle Tier
    _drawTier(
      canvas: canvas,
      centerX: centerX,
      topY: h * 0.30,
      bottomY: h * 0.60,
      baseHalfWidth: w * 0.35,
      darkColor: const Color(0xFF18493B),
      lightColor: const Color(0xFF226653),
    );

    // Top Tier
    _drawTier(
      canvas: canvas,
      centerX: centerX,
      topY: h * 0.14,
      bottomY: h * 0.42,
      baseHalfWidth: w * 0.25,
      darkColor: AppColors.pineGreen,
      lightColor: const Color(0xFF2C7D66),
    );

    // 4. Colorful Baubles / Ornaments
    _drawBauble(
      canvas,
      Offset(centerX - w * 0.22, h * 0.73),
      AppColors.christmasRed,
      3.5,
    );
    _drawBauble(
      canvas,
      Offset(centerX + w * 0.24, h * 0.75),
      AppColors.warmGold,
      3.5,
    );
    _drawBauble(
      canvas,
      Offset(centerX - w * 0.05, h * 0.68),
      AppColors.warmGlow,
      3.0,
    );
    _drawBauble(
      canvas,
      Offset(centerX - w * 0.15, h * 0.52),
      AppColors.warmGold,
      3.2,
    );
    _drawBauble(
      canvas,
      Offset(centerX + w * 0.16, h * 0.54),
      AppColors.christmasRed,
      3.2,
    );
    _drawBauble(
      canvas,
      Offset(centerX + w * 0.02, h * 0.46),
      const Color(0xFF38BDF8),
      3.0,
    );
    _drawBauble(
      canvas,
      Offset(centerX - w * 0.08, h * 0.34),
      AppColors.christmasRed,
      2.8,
    );
    _drawBauble(
      canvas,
      Offset(centerX + w * 0.09, h * 0.35),
      AppColors.warmGold,
      2.8,
    );

    // 5. Golden Shining Star on Top
    _drawStar(canvas, Offset(centerX, h * 0.12), w * 0.13);
  }

  void _drawTier({
    required Canvas canvas,
    required double centerX,
    required double topY,
    required double bottomY,
    required double baseHalfWidth,
    required Color darkColor,
    required Color lightColor,
  }) {
    final path = Path()
      ..moveTo(centerX, topY)
      ..lineTo(centerX - baseHalfWidth, bottomY)
      ..quadraticBezierTo(
        centerX,
        bottomY - 4,
        centerX + baseHalfWidth,
        bottomY,
      )
      ..close();

    final foliagePaint = Paint()
      ..shader =
          LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [lightColor, darkColor],
          ).createShader(
            Rect.fromLTRB(
              centerX - baseHalfWidth,
              topY,
              centerX + baseHalfWidth,
              bottomY,
            ),
          );

    canvas.drawPath(path, foliagePaint);

    // Snow caps on edge
    final snowPaint = Paint()
      ..color = Colors.white.withAlpha(216)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;

    final snowPath = Path()
      ..moveTo(centerX - baseHalfWidth + 3, bottomY - 1)
      ..quadraticBezierTo(
        centerX,
        bottomY - 5,
        centerX + baseHalfWidth - 3,
        bottomY - 1,
      );
    canvas.drawPath(snowPath, snowPaint);
  }

  void _drawBauble(Canvas canvas, Offset center, Color color, double radius) {
    // Bauble body
    final paint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.3),
        colors: [Colors.white, color, color.withAlpha(204)],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, paint);

    // Small highlight
    final highlightPaint = Paint()..color = Colors.white.withAlpha(204);
    canvas.drawCircle(
      Offset(center.dx - radius * 0.3, center.dy - radius * 0.3),
      radius * 0.3,
      highlightPaint,
    );
  }

  void _drawStar(Canvas canvas, Offset center, double size) {
    final half = size / 2;
    final starPaint = Paint()
      ..shader = const RadialGradient(
        colors: [Colors.white, AppColors.warmGlow, AppColors.warmGold],
      ).createShader(Rect.fromCircle(center: center, radius: half));

    final path = Path();
    const points = 5;
    const step = math.pi / points;
    double rot = -math.pi / 2;

    for (int i = 0; i < points * 2; i++) {
      final r = (i % 2 == 0) ? half : half * 0.45;
      final x = center.dx + math.cos(rot) * r;
      final y = center.dy + math.sin(rot) * r;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      rot += step;
    }
    path.close();

    // Outer glow
    final haloPaint = Paint()
      ..color = AppColors.warmGold.withAlpha(100)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(center, half * 0.9, haloPaint);

    canvas.drawPath(path, starPaint);
  }

  @override
  bool shouldRepaint(covariant _ChristmasTreePainter oldDelegate) =>
      oldDelegate.showGlow != showGlow;
}
