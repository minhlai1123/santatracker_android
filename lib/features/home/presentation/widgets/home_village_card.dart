import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/services/christmas_audio_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/christmas_typography.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../../../welcome/presentation/widgets/festive_badge.dart';

class HomeVillageCard extends StatelessWidget {
  final VoidCallback onOpenVillage;

  const HomeVillageCard({super.key, required this.onOpenVillage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        ChristmasAudioService.playButtonClick();
        onOpenVillage();
      },
      child: Container(
        key: const Key('home_village_card'),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          border: Border.all(
            color: AppColors.warmGold.withAlpha(90),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1E3A2F).withAlpha(16),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: AppColors.warmGold.withAlpha(20),
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
              // Illustrated Village Landscape Banner
              SizedBox(
                height: 100,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF0F2C24),
                              Color(0xFF1B4D3E),
                              Color(0xFF236350),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: CustomPaint(painter: _VillageLandscapePainter()),
                    ),
                    Positioned(
                      top: AppDimensions.spaceMD,
                      right: AppDimensions.spaceMD,
                      child: const FestiveBadge(
                        label: AppStrings.villageActiveBadge,
                        icon: Icons.holiday_village_rounded,
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
                                colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
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
                              Icons.holiday_village_rounded,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: AppDimensions.spaceSM),
                          const Text(
                            AppStrings.villageFeatureTitle,
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
                      AppStrings.villageFeatureDesc,
                      style: ChristmasTypography.bodyMedium,
                    ),
                    const SizedBox(height: AppDimensions.spaceLG),
                    FestiveButton(
                      key: const Key('btn_open_village'),
                      label: AppStrings.openVillageButton,
                      icon: Icons.explore_rounded,
                      style: FestiveButtonStyle.primary,
                      isExpanded: true,
                      onPressed: onOpenVillage,
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

class _VillageLandscapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Distant Pines
    final pinePaint = Paint()..color = const Color(0xFF0D251E);
    for (double x = 10; x <= w; x += 18) {
      final treeH = 22.0 + ((x * 5) % 10);
      final path = Path()
        ..moveTo(x - 8, h * 0.7)
        ..lineTo(x, h * 0.7 - treeH)
        ..lineTo(x + 8, h * 0.7)
        ..close();
      canvas.drawPath(path, pinePaint);
    }

    // Little Snow Cottage (Right side of banner)
    final cottageX = w * 0.78;
    final cottageY = h * 0.48;
    final cottagePaint = Paint()..color = const Color(0xFF422214);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cottageX, cottageY, 38, 26),
        const Radius.circular(2),
      ),
      cottagePaint,
    );
    // Glowing window
    final winPaint = Paint()..color = AppColors.lanternAmber;
    canvas.drawRect(
      Rect.fromLTWH(cottageX + 8, cottageY + 8, 10, 10),
      winPaint,
    );
    // Snow Roof
    final roof = Path()
      ..moveTo(cottageX - 4, cottageY + 2)
      ..lineTo(cottageX + 19, cottageY - 14)
      ..lineTo(cottageX + 42, cottageY + 2)
      ..close();
    canvas.drawPath(roof, Paint()..color = const Color(0xFFE8F3FA));

    // Rolling Snow Bank
    final snow = Path()
      ..moveTo(0, h * 0.65)
      ..quadraticBezierTo(w * 0.35, h * 0.58, w * 0.7, h * 0.68)
      ..quadraticBezierTo(w * 0.88, h * 0.72, w, h * 0.67)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(
      snow,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFFE2F0F9), Color(0xFFF3F8FC)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, h * 0.6, w, h * 0.4)),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
