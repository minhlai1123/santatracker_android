import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../../../welcome/presentation/widgets/festive_badge.dart';

class HomeSantaTrackerCard extends StatelessWidget {
  final VoidCallback onOpenSantaTracker;

  const HomeSantaTrackerCard({super.key, required this.onOpenSantaTracker});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('home_santa_tracker_card'),
      padding: const EdgeInsets.all(AppDimensions.spaceLG),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        border: Border.all(
          color: AppColors.pineGreen.withAlpha(70),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.pineGreen.withAlpha(15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.spaceSM),
                decoration: const BoxDecoration(
                  color: AppColors.greenTint,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.explore_rounded,
                  size: AppDimensions.iconSizeMD,
                  color: AppColors.pineGreen,
                ),
              ),
              const SizedBox(width: AppDimensions.spaceMD),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppStrings.trackerFeatureTitle,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        FestiveBadge(
                          label: AppStrings.santaTrackerActiveBadge,
                          backgroundColor: AppColors.greenTint,
                          textColor: AppColors.pineGreen,
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimensions.spaceXS),
                    Text(
                      AppStrings.trackerFeatureDesc,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceMD),
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
    );
  }
}
