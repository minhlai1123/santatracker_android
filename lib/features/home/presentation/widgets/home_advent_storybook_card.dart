import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/services/christmas_audio_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/christmas_typography.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../../../welcome/presentation/widgets/festive_badge.dart';

class HomeAdventStorybookCard extends StatelessWidget {
  final VoidCallback onOpenAdvent;

  const HomeAdventStorybookCard({super.key, required this.onOpenAdvent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        ChristmasAudioService.playButtonClick();
        onOpenAdvent();
      },
      child: Container(
        key: const Key('home_advent_storybook_card'),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          border: Border.all(
            color: AppColors.warmGold.withAlpha(90),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF331D08).withAlpha(16),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: AppColors.warmGold.withAlpha(24),
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
              // Illustrated Magical Storybook Banner
              SizedBox(
                height: 100,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF2E1B0E),
                              Color(0xFF523315),
                              Color(0xFF784919),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: CustomPaint(painter: _AdventStorybookPainter()),
                    ),
                    Positioned(
                      top: AppDimensions.spaceMD,
                      right: AppDimensions.spaceMD,
                      child: const FestiveBadge(
                        label: AppStrings.adventActiveBadge,
                        icon: Icons.menu_book_rounded,
                        backgroundColor: Color(0xFFFEF3C7),
                        textColor: Color(0xFF92400E),
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
                                colors: [Color(0xFFFBBF24), Color(0xFFD97706)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amber.withAlpha(80),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.auto_stories_rounded,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: AppDimensions.spaceSM),
                          const Text(
                            AppStrings.adventFeatureTitle,
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
                      AppStrings.adventFeatureDesc,
                      style: ChristmasTypography.bodyMedium,
                    ),
                    const SizedBox(height: AppDimensions.spaceLG),
                    FestiveButton(
                      key: const Key('btn_open_advent'),
                      label: AppStrings.openAdventButton,
                      icon: Icons.auto_stories_rounded,
                      style: FestiveButtonStyle.primary,
                      isExpanded: true,
                      onPressed: onOpenAdvent,
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

class _AdventStorybookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Candlelight Glow on right
    final glowCenter = Offset(w * 0.8, h * 0.45);
    final candleGlow = Paint()
      ..shader = RadialGradient(
        colors: [const Color(0xFFFDE68A).withAlpha(80), Colors.transparent],
      ).createShader(Rect.fromCircle(center: glowCenter, radius: 55));
    canvas.drawCircle(glowCenter, 55, candleGlow);

    // Magical stardust swirl
    final sparklePaint = Paint()..color = AppColors.warmGold;
    canvas.drawCircle(Offset(w * 0.4, h * 0.3), 2.0, sparklePaint);
    canvas.drawCircle(Offset(w * 0.55, h * 0.22), 2.5, sparklePaint);
    canvas.drawCircle(Offset(w * 0.68, h * 0.35), 1.8, sparklePaint);
    canvas.drawCircle(Offset(w * 0.9, h * 0.28), 2.2, sparklePaint);

    // Open Book Silhouette
    final bookCenter = Offset(w * 0.76, h * 0.58);
    final bookPaint = Paint()..color = const Color(0xFFFFFBEB);
    // Left page
    final leftPage = Path()
      ..moveTo(bookCenter.dx, bookCenter.dy + 8)
      ..cubicTo(
        bookCenter.dx - 12,
        bookCenter.dy + 7,
        bookCenter.dx - 22,
        bookCenter.dy + 3,
        bookCenter.dx - 26,
        bookCenter.dy - 12,
      )
      ..lineTo(bookCenter.dx - 26, bookCenter.dy - 20)
      ..cubicTo(
        bookCenter.dx - 20,
        bookCenter.dy - 12,
        bookCenter.dx - 10,
        bookCenter.dx > 0 ? bookCenter.dy - 8 : 0,
        bookCenter.dx,
        bookCenter.dy - 8,
      )
      ..close();
    canvas.drawPath(leftPage, bookPaint);

    // Right page
    final rightPage = Path()
      ..moveTo(bookCenter.dx, bookCenter.dy + 8)
      ..cubicTo(
        bookCenter.dx + 12,
        bookCenter.dy + 7,
        bookCenter.dx + 22,
        bookCenter.dy + 3,
        bookCenter.dx + 26,
        bookCenter.dy - 12,
      )
      ..lineTo(bookCenter.dx + 26, bookCenter.dy - 20)
      ..cubicTo(
        bookCenter.dx + 20,
        bookCenter.dy - 12,
        bookCenter.dx + 10,
        bookCenter.dx > 0 ? bookCenter.dy - 8 : 0,
        bookCenter.dx,
        bookCenter.dy - 8,
      )
      ..close();
    canvas.drawPath(rightPage, bookPaint);

    // Spine
    final spinePaint = Paint()
      ..color = const Color(0xFF92400E)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(bookCenter.dx, bookCenter.dy - 8),
      Offset(bookCenter.dx, bookCenter.dy + 9),
      spinePaint,
    );

    // Tiny Candle next to book
    final candleX = w * 0.88;
    final candleY = h * 0.55;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(candleX, candleY, 6, 16),
        const Radius.circular(1.5),
      ),
      Paint()..color = const Color(0xFFE2E8F0),
    );
    // Flame
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(candleX + 3, candleY - 3),
        width: 4,
        height: 7,
      ),
      Paint()..color = const Color(0xFFF59E0B),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
