import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/services/christmas_audio_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/christmas_typography.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../../../welcome/presentation/widgets/festive_badge.dart';

class HomeMiniGamesCard extends StatelessWidget {
  final VoidCallback onOpenMiniGames;

  const HomeMiniGamesCard({super.key, required this.onOpenMiniGames});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        ChristmasAudioService.playButtonClick();
        onOpenMiniGames();
      },
      child: Container(
        key: const Key('home_mini_games_card'),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          border: Border.all(
            color: AppColors.christmasRed.withAlpha(70),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4C0E18).withAlpha(16),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: AppColors.christmasRed.withAlpha(20),
              blurRadius: 24,
              spreadRadius: -4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Illustrated Mini Games Toy & Gift Workshop Banner
              SizedBox(
                height: 100,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF4A0A16),
                              Color(0xFF88132A),
                              Color(0xFFB91C1C),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: CustomPaint(painter: _MiniGamesPlayroomPainter()),
                    ),
                    Positioned(
                      top: AppDimensions.spaceMD,
                      right: AppDimensions.spaceMD,
                      child: const FestiveBadge(
                        label: AppStrings.miniGamesActiveBadge,
                        icon: Icons.videogame_asset_rounded,
                        backgroundColor: Color(0xFFDCFCE7),
                        textColor: AppColors.pineGreen,
                      ),
                    ),
                    Positioned(
                      bottom: AppDimensions.spaceMD,
                      left: AppDimensions.spaceLG,
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFEF4444), Color(0xFFB91C1C)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withAlpha(80),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.sports_esports_rounded,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: AppDimensions.spaceSM),
                          const Text(
                            AppStrings.gamesFeatureTitle,
                            style: TextStyle(
                              fontFamily: ChristmasTypography.fontFamilyUI,
                              fontFamilyFallback:
                                  ChristmasTypography.fallbackFonts,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.3,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 6,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Card Body Content
              Padding(
                padding: const EdgeInsets.all(AppDimensions.spaceLG),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      AppStrings.gamesFeatureDesc,
                      style: ChristmasTypography.bodyMedium,
                    ),
                    const SizedBox(height: AppDimensions.spaceLG),
                    FestiveButton(
                      key: const Key('btn_open_mini_games'),
                      label: AppStrings.openMiniGamesButton,
                      icon: Icons.sports_esports_rounded,
                      style: FestiveButtonStyle.primary,
                      isExpanded: true,
                      onPressed: onOpenMiniGames,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniGamesPlayroomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Soft warm room glow in the center
    final glowPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [const Color(0xFFFDE047).withAlpha(50), Colors.transparent],
          ).createShader(
            Rect.fromCircle(center: Offset(w * 0.75, h * 0.5), radius: 60),
          );
    canvas.drawCircle(Offset(w * 0.75, h * 0.5), 60, glowPaint);

    // Decorative floating stars
    final starPaint = Paint()..color = AppColors.warmGold.withAlpha(180);
    canvas.drawCircle(Offset(w * 0.45, h * 0.25), 2.5, starPaint);
    canvas.drawCircle(Offset(w * 0.6, h * 0.35), 1.8, starPaint);
    canvas.drawCircle(Offset(w * 0.85, h * 0.2), 2.2, starPaint);

    // Gift Box 1 (Larger, emerald green with gold ribbon on right)
    final box1X = w * 0.72;
    final box1Y = h * 0.48;
    final box1Paint = Paint()..color = const Color(0xFF15803D);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(box1X, box1Y, 32, 28),
        const Radius.circular(3),
      ),
      box1Paint,
    );
    // Ribbon gold vertical
    final ribbonPaint = Paint()..color = AppColors.warmGold;
    canvas.drawRect(Rect.fromLTWH(box1X + 13, box1Y, 6, 28), ribbonPaint);
    // Ribbon gold horizontal
    canvas.drawRect(Rect.fromLTWH(box1X, box1Y + 11, 32, 6), ribbonPaint);
    // Bow
    canvas.drawCircle(Offset(box1X + 16, box1Y - 2), 4, ribbonPaint);

    // Gift Box 2 (Smaller, gold with red ribbon next to it)
    final box2X = w * 0.84;
    final box2Y = h * 0.54;
    final box2Paint = Paint()..color = const Color(0xFFF59E0B);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(box2X, box2Y, 24, 22),
        const Radius.circular(2),
      ),
      box2Paint,
    );
    // Red ribbon
    final redRibbon = Paint()..color = const Color(0xFFDC2626);
    canvas.drawRect(Rect.fromLTWH(box2X + 9, box2Y, 5, 22), redRibbon);
    canvas.drawRect(Rect.fromLTWH(box2X, box2Y + 8, 24, 5), redRibbon);

    // Candy Cane diagonal stripe on left
    final caneX = w * 0.63;
    final caneY = h * 0.45;
    final canePath = Path()
      ..moveTo(caneX, caneY + 30)
      ..lineTo(caneX, caneY + 12)
      ..arcToPoint(
        Offset(caneX + 14, caneY + 12),
        radius: const Radius.circular(7),
        clockwise: true,
      );
    final canePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(canePath, canePaint);

    // Candy cane red stripes
    final redStripe = Paint()
      ..color = const Color(0xFFDC2626)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round;
    final redDash = Path()
      ..moveTo(caneX, caneY + 22)
      ..lineTo(caneX, caneY + 18);
    canvas.drawPath(redDash, redStripe);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
