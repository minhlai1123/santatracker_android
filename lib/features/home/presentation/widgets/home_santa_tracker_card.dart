import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/services/christmas_audio_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/christmas_typography.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../../../welcome/presentation/widgets/festive_badge.dart';

class HomeSantaTrackerCard extends StatelessWidget {
  final VoidCallback onOpenSantaTracker;

  const HomeSantaTrackerCard({super.key, required this.onOpenSantaTracker});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        ChristmasAudioService.playButtonClick();
        onOpenSantaTracker();
      },
      child: Container(
        key: const Key('home_santa_tracker_card'),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          border: Border.all(
            color: const Color(0xFF1E3A8A).withAlpha(60),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F1E3D).withAlpha(16),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: AppColors.auroraTeal.withAlpha(20),
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
              // Illustrated Banner: Santa Sleigh & Starry Aurora Flight
              SizedBox(
                height: 100,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF091428),
                              Color(0xFF132D54),
                              Color(0xFF1E4072),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: CustomPaint(painter: _SantaSleighFlightPainter()),
                    ),
                    Positioned(
                      top: AppDimensions.spaceMD,
                      right: AppDimensions.spaceMD,
                      child: const FestiveBadge(
                        label: AppStrings.santaTrackerActiveBadge,
                        icon: Icons.radar_rounded,
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
                                colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withAlpha(80),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.explore_rounded,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: AppDimensions.spaceSM),
                          const Text(
                            AppStrings.trackerFeatureTitle,
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
                      AppStrings.trackerFeatureDesc,
                      style: ChristmasTypography.bodyMedium,
                    ),
                    const SizedBox(height: AppDimensions.spaceLG),
                    FestiveButton(
                      key: const Key('btn_open_santa_tracker'),
                      label: AppStrings.openSantaTrackerButton,
                      icon: Icons.public_rounded,
                      style: FestiveButtonStyle.secondary,
                      isExpanded: true,
                      onPressed: onOpenSantaTracker,
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

class _SantaSleighFlightPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Aurora curve
    final auroraPath = Path()
      ..moveTo(0, h * 0.4)
      ..quadraticBezierTo(w * 0.4, h * 0.1, w * 0.8, h * 0.35)
      ..lineTo(w, h * 0.3)
      ..lineTo(w, 0)
      ..lineTo(0, 0)
      ..close();

    final auroraPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          AppColors.auroraTeal.withAlpha(0),
          AppColors.auroraTeal.withAlpha(45),
          Colors.transparent,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(auroraPath, auroraPaint);

    // Crescent Moon
    final moonCenter = Offset(w * 0.84, h * 0.35);
    final moonPaint = Paint()..color = const Color(0xFFFFF7D6);
    canvas.drawCircle(moonCenter, 14, moonPaint);
    final shadowPaint = Paint()..color = const Color(0xFF132D54);
    canvas.drawCircle(
      Offset(moonCenter.dx - 4, moonCenter.dy - 3),
      12,
      shadowPaint,
    );

    // Golden Flight Path Arc
    final path = Path()
      ..moveTo(w * 0.1, h * 0.75)
      ..quadraticBezierTo(w * 0.45, h * 0.3, w * 0.75, h * 0.38);

    final flightPaint = Paint()
      ..color = AppColors.warmGold.withAlpha(160)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    canvas.drawPath(path, flightPaint);

    // Gold Sparkles along trail
    final starPaint = Paint()..color = AppColors.warmGold;
    canvas.drawCircle(Offset(w * 0.3, h * 0.52), 2.2, starPaint);
    canvas.drawCircle(Offset(w * 0.48, h * 0.36), 2.8, starPaint);
    canvas.drawCircle(Offset(w * 0.62, h * 0.35), 2.0, starPaint);

    // Flying Sleigh Silhouette at head of trail
    final sleighCenter = Offset(w * 0.73, h * 0.38);
    final sleighPaint = Paint()..color = AppColors.warmGold;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: sleighCenter, width: 22, height: 10),
        const Radius.circular(3),
      ),
      sleighPaint,
    );
    // Sleigh runner
    canvas.drawLine(
      Offset(sleighCenter.dx - 12, sleighCenter.dy + 7),
      Offset(sleighCenter.dx + 12, sleighCenter.dy + 6),
      Paint()
        ..color = AppColors.warmGold
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
