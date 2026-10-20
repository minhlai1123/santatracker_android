import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/christmas_typography.dart';
import '../../../../shared/widgets/christmas_tree_decoration.dart';

/// ChristmasHeroScene — Immersive Illustrated Holiday Hero Banner
///
/// Features:
/// - Cozy winter night panorama with glowing moon and snowdrifts
/// - Grand illuminated Christmas Tree with radiant star and gift boxes
/// - Cozy snow-covered cottage with glowing warm amber window & chimney smoke
/// - Integrated display title in Lobster font with warm festive glow
class ChristmasHeroScene extends StatefulWidget {
  const ChristmasHeroScene({super.key});

  @override
  State<ChristmasHeroScene> createState() => _ChristmasHeroSceneState();
}

class _ChristmasHeroSceneState extends State<ChristmasHeroScene>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;

  bool get _isTestEnvironment =>
      WidgetsBinding.instance.runtimeType.toString().contains('Test');

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    if (!_isTestEnvironment) {
      _animController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 280),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        gradient: const LinearGradient(
          colors: [Color(0xFF071428), Color(0xFF0E2445), Color(0xFF183B68)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF071428).withAlpha(140),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: AppColors.warmGold.withAlpha(20),
            blurRadius: 30,
            spreadRadius: -4,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.warmGold.withAlpha(60), width: 1.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        child: Stack(
          children: [
            // 1. Scenery Painter (Cottage, Moon, Snowdrifts, Distant trees)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _animController,
                builder: (context, _) {
                  return CustomPaint(
                    painter: _HeroSceneryPainter(
                      pulseProgress: _animController.value,
                    ),
                  );
                },
              ),
            ),

            // 2. Foreground Content (Tree, Titles, Badges)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.spaceLG,
                AppDimensions.spaceXL,
                AppDimensions.spaceLG,
                AppDimensions.spaceLG,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Center Tree with Radiant Halo
                  const Center(
                    child: ChristmasTreeDecoration(
                      width: 110,
                      height: 126,
                      showGlow: true,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spaceSM),

                  // App Title (Lobster Display Font)
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      AppStrings.appName,
                      textAlign: TextAlign.center,
                      style: ChristmasTypography.displayLarge.copyWith(
                        color: const Color(0xFFFFF7ED),
                        fontSize: 32,
                        shadows: [
                          Shadow(
                            color: AppColors.christmasRed.withAlpha(220),
                            blurRadius: 16,
                            offset: const Offset(0, 2),
                          ),
                          Shadow(
                            color: AppColors.warmGold.withAlpha(140),
                            blurRadius: 28,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Greeting Subtitle
                  Text(
                    AppStrings.homeGreetingPrefix,
                    textAlign: TextAlign.center,
                    style: ChristmasTypography.titleSmall.copyWith(
                      color: AppColors.iceBlue,
                      fontSize: 15,
                      letterSpacing: 0.4,
                      shadows: [
                        Shadow(
                          color: Colors.black.withAlpha(180),
                          blurRadius: 8,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spaceMD),

                  // Frost Glass Tagline Badge
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.spaceMD,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(28),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusFull,
                        ),
                        border: Border.all(
                          color: Colors.white.withAlpha(80),
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(30),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.auto_awesome_rounded,
                            size: 15,
                            color: AppColors.warmGold,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            AppStrings.festiveTagline,
                            style: ChristmasTypography.badgeLabel.copyWith(
                              color: const Color(0xFFFFFDF5),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroSceneryPainter extends CustomPainter {
  final double pulseProgress;

  const _HeroSceneryPainter({required this.pulseProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Glowing Full Moon / Polar Light
    final moonCenter = Offset(w * 0.16, h * 0.22);
    final moonGlowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.candlelight.withAlpha(100),
          AppColors.candlelight.withAlpha(30),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: moonCenter, radius: 46));
    canvas.drawCircle(moonCenter, 46, moonGlowPaint);

    final moonPaint = Paint()..color = const Color(0xFFFFF9E6);
    canvas.drawCircle(moonCenter, 18, moonPaint);

    // 2. Starry Sky Sparkles
    final stars = [
      Offset(w * 0.08, h * 0.08),
      Offset(w * 0.25, h * 0.06),
      Offset(w * 0.40, h * 0.10),
      Offset(w * 0.60, h * 0.05),
      Offset(w * 0.78, h * 0.08),
      Offset(w * 0.90, h * 0.14),
      Offset(w * 0.85, h * 0.25),
      Offset(w * 0.10, h * 0.36),
    ];

    for (int i = 0; i < stars.length; i++) {
      final pos = stars[i];
      final starOpacity = (120 + ((i + pulseProgress * 2) % 1.0 * 135))
          .clamp(50, 255)
          .toInt();
      final starPaint = Paint()..color = Colors.white.withAlpha(starOpacity);
      canvas.drawCircle(pos, 1.2, starPaint);
    }

    // 3. Cozy Snow Cottage (Left Background)
    final cottageX = w * 0.06;
    final cottageY = h * 0.72;
    const cottageW = 54.0;
    const cottageH = 38.0;

    // Cabin Walls
    final wallPaint = Paint()..color = const Color(0xFF532E1D);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cottageX, cottageY, cottageW, cottageH),
        const Radius.circular(3),
      ),
      wallPaint,
    );

    // Chimney & Smoke
    final chimneyPaint = Paint()..color = const Color(0xFF381F14);
    canvas.drawRect(
      Rect.fromLTWH(cottageX + 36, cottageY - 14, 10, 16),
      chimneyPaint,
    );

    final smokePaint = Paint()
      ..color = Colors.white.withAlpha(70)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawCircle(Offset(cottageX + 41, cottageY - 20), 5, smokePaint);
    canvas.drawCircle(Offset(cottageX + 43, cottageY - 28), 7, smokePaint);

    // Glowing Golden Window
    final windowPaint = Paint()
      ..color = AppColors.lanternAmber
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cottageX + 10, cottageY + 12, 14, 14),
        const Radius.circular(2),
      ),
      windowPaint,
    );

    // Warm Ambient Light from Window
    final windowGlow = Paint()
      ..shader =
          RadialGradient(
            colors: [AppColors.lanternAmber.withAlpha(90), Colors.transparent],
          ).createShader(
            Rect.fromCircle(
              center: Offset(cottageX + 17, cottageY + 19),
              radius: 24,
            ),
          );
    canvas.drawCircle(Offset(cottageX + 17, cottageY + 19), 24, windowGlow);

    // Snow-dusted Pitched Roof
    final roofPath = Path()
      ..moveTo(cottageX - 6, cottageY + 2)
      ..lineTo(cottageX + cottageW / 2, cottageY - 18)
      ..lineTo(cottageX + cottageW + 6, cottageY + 2)
      ..close();

    final roofPaint = Paint()..color = const Color(0xFFEBF4FA);
    canvas.drawPath(roofPath, roofPaint);

    // 4. Little Fir Trees (Right Background)
    final pinePaint = Paint()..color = const Color(0xFF0F3227);
    final pineSnowPaint = Paint()..color = const Color(0xFFD6E8F5);

    _drawTinyTree(
      canvas,
      Offset(w * 0.88, h * 0.74),
      38,
      pinePaint,
      pineSnowPaint,
    );
    _drawTinyTree(
      canvas,
      Offset(w * 0.94, h * 0.76),
      28,
      pinePaint,
      pineSnowPaint,
    );

    // 5. Rolling Foreground Snowdrifts
    final driftPath = Path()
      ..moveTo(0, h * 0.85)
      ..quadraticBezierTo(w * 0.35, h * 0.80, w * 0.65, h * 0.87)
      ..quadraticBezierTo(w * 0.85, h * 0.92, w, h * 0.88)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    final driftPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFDCEAF5), Color(0xFFEDF5FC)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, h * 0.8, w, h * 0.2));

    canvas.drawPath(driftPath, driftPaint);
  }

  void _drawTinyTree(
    Canvas canvas,
    Offset baseCenter,
    double height,
    Paint treePaint,
    Paint snowPaint,
  ) {
    final halfW = height * 0.35;
    final treePath = Path()
      ..moveTo(baseCenter.dx - halfW, baseCenter.dy)
      ..lineTo(baseCenter.dx, baseCenter.dy - height)
      ..lineTo(baseCenter.dx + halfW, baseCenter.dy)
      ..close();
    canvas.drawPath(treePath, treePaint);

    final snowCap = Path()
      ..moveTo(baseCenter.dx - halfW * 0.5, baseCenter.dy - height * 0.5)
      ..lineTo(baseCenter.dx, baseCenter.dy - height)
      ..lineTo(baseCenter.dx + halfW * 0.5, baseCenter.dy - height * 0.5)
      ..close();
    canvas.drawPath(snowCap, snowPaint);
  }

  @override
  bool shouldRepaint(covariant _HeroSceneryPainter oldDelegate) =>
      oldDelegate.pulseProgress != pulseProgress;
}
