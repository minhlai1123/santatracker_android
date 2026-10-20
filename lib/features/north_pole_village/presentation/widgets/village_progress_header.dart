import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/christmas_typography.dart';
import '../../domain/models/village_exploration_state.dart';

class VillageProgressHeader extends StatelessWidget {
  final VillageExplorationState state;

  const VillageProgressHeader({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimensions.spaceSM),
              decoration: const BoxDecoration(
                color: AppColors.greenTint,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.holiday_village_rounded,
                size: AppDimensions.iconSizeMD,
                color: AppColors.pineGreen,
              ),
            ),
            const SizedBox(width: AppDimensions.spaceMD),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    AppStrings.villageScreenTitle,
                    style: ChristmasTypography.titleLarge,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${AppStrings.villageProgressLabel}: ${state.progressDisplay}',
                    key: const Key('village_progress_text'),
                    style: ChristmasTypography.badgeLabel.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: state.isFullyExplored
                    ? AppColors.greenTint
                    : AppColors.goldTint,
                borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                border: Border.all(
                  color: state.isFullyExplored
                      ? AppColors.pineGreen.withAlpha(80)
                      : AppColors.warmGold.withAlpha(120),
                ),
              ),
              child: Text(
                '${(state.progressRatio * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: state.isFullyExplored
                      ? AppColors.pineGreen
                      : const Color(0xFF92400E),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceSM),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
          child: LinearProgressIndicator(
            key: const Key('village_progress_bar'),
            value: state.progressRatio,
            minHeight: 8,
            backgroundColor: const Color(0xFFE2E8F0),
            valueColor: AlwaysStoppedAnimation<Color>(
              state.isFullyExplored ? AppColors.pineGreen : AppColors.warmGold,
            ),
          ),
        ),
        if (state.errorMessage != null) ...[
          const SizedBox(height: AppDimensions.spaceSM),
          Container(
            padding: const EdgeInsets.all(AppDimensions.spaceSM),
            decoration: BoxDecoration(
              color: AppColors.redTint,
              borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
              border: Border.all(color: AppColors.christmasRed.withAlpha(80)),
            ),
            child: Text(
              state.errorMessage!,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.christmasRed,
              ),
            ),
          ),
        ],
        if (state.isFullyExplored) ...[
          const SizedBox(height: AppDimensions.spaceMD),
          Container(
            key: const Key('village_completed_banner'),
            padding: const EdgeInsets.all(AppDimensions.spaceMD),
            decoration: BoxDecoration(
              color: AppColors.greenTint,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              border: Border.all(color: AppColors.pineGreen.withAlpha(90)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.pineGreen.withAlpha(20),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.celebration_rounded,
                  size: AppDimensions.iconSizeMD,
                  color: AppColors.pineGreen,
                ),
                SizedBox(width: AppDimensions.spaceSM),
                Expanded(
                  child: Text(
                    AppStrings.villageCompletedBanner,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.pineGreen,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
