import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/christmas_typography.dart';
import '../../domain/models/festive_notification_item.dart';
import 'even_day_special_badge.dart';

class NotificationPreviewCard extends StatelessWidget {
  final FestiveNotificationItem item;

  const NotificationPreviewCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isEven = item.isEvenDaySpecial;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        border: Border.all(
          color: isEven
              ? AppColors.warmGold.withAlpha(160)
              : AppColors.cardBorder,
          width: isEven ? 1.8 : 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: isEven
                ? AppColors.warmGold.withAlpha(35)
                : const Color(0xFF0F172A).withAlpha(12),
            blurRadius: isEven ? 16 : 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Accent Bar (Gold shimmer if Even Day, Pine Green if Odd Day)
            Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isEven
                      ? [
                          const Color(0xFFF59E0B),
                          const Color(0xFFFDE68A),
                          const Color(0xFFD97706),
                        ]
                      : [
                          AppColors.pineGreen,
                          const Color(0xFF34D399),
                          AppColors.evergreen,
                        ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(AppDimensions.spaceMD),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Identifier Header Row
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          gradient: isEven
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFFEF4444),
                                    Color(0xFFB91C1C),
                                  ],
                                )
                              : const LinearGradient(
                                  colors: [
                                    Color(0xFF047857),
                                    Color(0xFF065F46),
                                  ],
                                ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.park_rounded,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spaceSM),
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                AppStrings.appName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: ChristmasTypography.fontFamilyUI,
                                  fontFamilyFallback:
                                      ChristmasTypography.fallbackFonts,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                            const Text(
                              ' • Today',
                              style: TextStyle(
                                fontFamily: ChristmasTypography.fontFamilyUI,
                                fontFamilyFallback:
                                    ChristmasTypography.fallbackFonts,
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spaceSM),
                      if (isEven)
                        const EvenDaySpecialBadge(isCompact: true)
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.spaceSM,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0F2FE),
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusFull,
                            ),
                          ),
                          child: const Text(
                            AppStrings.oddDayCheerBadge,
                            style: TextStyle(
                              fontFamily: ChristmasTypography.fontFamilyUI,
                              fontFamilyFallback:
                                  ChristmasTypography.fallbackFonts,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0369A1),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spaceSM),

                  // Notification Title
                  Text(
                    item.title,
                    style: TextStyle(
                      fontFamily: ChristmasTypography.fontFamilyUI,
                      fontFamilyFallback: ChristmasTypography.fallbackFonts,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isEven
                          ? const Color(0xFF92400E)
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spaceXS),

                  // Notification Body
                  Text(
                    item.body,
                    style: const TextStyle(
                      fontFamily: ChristmasTypography.fontFamilyUI,
                      fontFamilyFallback: ChristmasTypography.fallbackFonts,
                      fontSize: 13,
                      height: 1.35,
                      color: AppColors.textPrimary,
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
