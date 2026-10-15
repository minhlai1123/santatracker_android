import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/advent_storybook_state.dart';

class StorybookCoverHeader extends StatelessWidget {
  final AdventStorybookState state;

  const StorybookCoverHeader({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceLG),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.christmasRed.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_stories_rounded,
                  size: AppDimensions.iconSizeMD,
                  color: AppColors.christmasRed,
                ),
              ),
              const SizedBox(width: AppDimensions.spaceMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      AppStrings.adventScreenTitle,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AppStrings.adventSubtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceLG),

          // Dual Progress Indicators
          Row(
            children: [
              Expanded(
                child: _buildProgressBlock(
                  label: AppStrings.adventUnlockedCountLabel,
                  count: state.unlockedCount,
                  total: state.totalChapters,
                  percentage: state.unlockedPercentage,
                  color: AppColors.warmGold,
                ),
              ),
              const SizedBox(width: AppDimensions.spaceMD),
              Expanded(
                child: _buildProgressBlock(
                  label: AppStrings.adventReadCountLabel,
                  count: state.readCount,
                  total: state.totalChapters,
                  percentage: state.readPercentage,
                  color: AppColors.pineGreen,
                ),
              ),
            ],
          ),

          // Completion celebration banners
          if (state.isAllRead) ...[
            const SizedBox(height: AppDimensions.spaceMD),
            Container(
              padding: const EdgeInsets.all(AppDimensions.spaceSM),
              decoration: BoxDecoration(
                color: const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                border: Border.all(color: AppColors.pineGreen),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.verified_rounded,
                    color: AppColors.pineGreen,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      AppStrings.allChaptersReadBanner,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.pineGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else if (state.isAllUnlocked) ...[
            const SizedBox(height: AppDimensions.spaceMD),
            Container(
              padding: const EdgeInsets.all(AppDimensions.spaceSM),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                border: Border.all(color: AppColors.warmGold),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    color: Color(0xFFB45309),
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      AppStrings.allChaptersUnlockedBanner,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFB45309),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressBlock({
    required String label,
    required int count,
    required int total,
    required double percentage,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceSM),
      decoration: BoxDecoration(
        color: color.withAlpha(15),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '$count / $total',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 6,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
