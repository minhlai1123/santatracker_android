import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/christmas_typography.dart';
import '../../../welcome/presentation/widgets/festive_badge.dart';
import '../../domain/models/advent_chapter.dart';
import '../../domain/models/advent_chapter_status.dart';

class StorybookChapterCard extends StatelessWidget {
  final AdventChapter chapter;
  final AdventChapterStatus status;
  final VoidCallback onTap;

  const StorybookChapterCard({
    super.key,
    required this.chapter,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLocked = status == AdventChapterStatus.locked;
    final bool isRead = status == AdventChapterStatus.read;

    final Color statusColor = isRead
        ? AppColors.pineGreen
        : (isLocked ? AppColors.textMuted : AppColors.warmGold);

    final String statusLabel = isRead
        ? AppStrings.adventStatusRead
        : (isLocked
              ? AppStrings.adventStatusLocked
              : AppStrings.adventStatusUnlocked);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.spaceMD),
          decoration: BoxDecoration(
            color: isLocked ? const Color(0xFFF8FAFC) : AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            border: Border.all(
              color: isLocked
                  ? AppColors.cardBorder
                  : (isRead
                        ? AppColors.pineGreen.withAlpha(80)
                        : AppColors.warmGold.withAlpha(120)),
              width: isLocked ? 1.0 : 1.5,
            ),
            boxShadow: isLocked
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withAlpha(6),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(25),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: isLocked
                          ? Icon(
                              Icons.lock_rounded,
                              size: 18,
                              color: statusColor,
                            )
                          : Text(
                              '${chapter.dayNumber}',
                              style: ChristmasTypography.titleSmall.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spaceSM),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppStrings.adventDayPrefix} ${chapter.dayNumber}: ${chapter.title}',
                          style: ChristmasTypography.cardTitle.copyWith(
                            fontSize: 14,
                            color: isLocked
                                ? AppColors.textSecondary
                                : AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        FestiveBadge(
                          label: statusLabel,
                          backgroundColor: statusColor.withAlpha(20),
                          textColor: statusColor,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isLocked
                        ? Icons.lock_outline_rounded
                        : Icons.chevron_right_rounded,
                    color: isLocked ? AppColors.textMuted : AppColors.pineGreen,
                  ),
                ],
              ),
              if (isLocked) ...[
                const SizedBox(height: AppDimensions.spaceSM),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spaceSM,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          chapter.unlockRuleDescription,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
