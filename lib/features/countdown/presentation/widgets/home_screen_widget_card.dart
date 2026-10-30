import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/services/christmas_audio_service.dart';
import '../../../../core/services/christmas_widget_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/christmas_typography.dart';
import '../../../../shared/widgets/festive_button.dart';

class HomeScreenWidgetCard extends StatelessWidget {
  final DateTime Function()? clock;

  const HomeScreenWidgetCard({super.key, this.clock});

  void _syncWidget(BuildContext context) async {
    ChristmasAudioService.playButtonClick();
    await ChristmasWidgetService.updateWidget();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: Color(0xFFFEF08A),
                size: 20,
              ),
              SizedBox(width: AppDimensions.spaceSM),
              Expanded(
                child: Text(
                  AppStrings.widgetSyncedToast,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.pineGreen,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = clock?.call() ?? DateTime.now();
    final widgetData = ChristmasWidgetService.getWidgetData(date: now);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        border: Border.all(color: AppColors.warmGold.withAlpha(90), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF153C32).withAlpha(14),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppDimensions.spaceLG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section Header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF10B981), Color(0xFF047857)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF10B981).withAlpha(60),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.widgets_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: AppDimensions.spaceMD),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.widgetSectionTitle,
                      style: ChristmasTypography.titleLarge,
                    ),
                    SizedBox(height: 2),
                    Text(
                      AppStrings.widgetSectionSubtitle,
                      style: ChristmasTypography.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceLG),

          // Realistic Interactive Miniature Widget Preview
          Center(
            child: Container(
              width: 220,
              padding: const EdgeInsets.all(AppDimensions.spaceMD),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF153C32),
                    Color(0xFF1B4D3E),
                    Color(0xFF0F2A22),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE8BE63), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(50),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Widget header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.park_rounded,
                        color: Color(0xFFFEF08A),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          widgetData.title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: ChristmasTypography.fontFamilyUI,
                            fontFamilyFallback:
                                ChristmasTypography.fallbackFonts,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFFEF08A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spaceSM),

                  // Big Countdown Days Number
                  Text(
                    '${widgetData.daysLeft}',
                    style: const TextStyle(
                      fontFamily: ChristmasTypography.fontFamilyUI,
                      fontFamilyFallback: ChristmasTypography.fallbackFonts,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Label
                  Text(
                    widgetData.daysLabel,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: ChristmasTypography.fontFamilyUI,
                      fontFamilyFallback: ChristmasTypography.fallbackFonts,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFD1FAE5),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spaceSM),

                  // Pill Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8BE63).withAlpha(50),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE8BE63),
                        width: 0.8,
                      ),
                    ),
                    child: Text(
                      widgetData.statusBadge,
                      style: const TextStyle(
                        fontFamily: ChristmasTypography.fontFamilyUI,
                        fontFamilyFallback: ChristmasTypography.fallbackFonts,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFEF08A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceLG),

          // How to add guide box
          Container(
            padding: const EdgeInsets.all(AppDimensions.spaceMD),
            decoration: BoxDecoration(
              color: AppColors.softSnow,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.phone_android_rounded,
                      size: 16,
                      color: AppColors.pineGreen,
                    ),
                    SizedBox(width: AppDimensions.spaceSM),
                    Expanded(
                      child: Text(
                        AppStrings.widgetHowToAddAndroid,
                        style: ChristmasTypography.bodySmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppDimensions.spaceSM),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.phone_iphone_rounded,
                      size: 16,
                      color: AppColors.christmasRed,
                    ),
                    SizedBox(width: AppDimensions.spaceSM),
                    Expanded(
                      child: Text(
                        AppStrings.widgetHowToAddIos,
                        style: ChristmasTypography.bodySmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.spaceMD),

          // Sync Widget Button
          FestiveButton(
            key: const Key('btn_sync_widget'),
            label: AppStrings.syncWidgetButton,
            icon: Icons.sync_rounded,
            style: FestiveButtonStyle.secondary,
            isExpanded: true,
            onPressed: () => _syncWidget(context),
          ),
        ],
      ),
    );
  }
}
