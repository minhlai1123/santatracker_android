import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../../../welcome/presentation/widgets/festive_badge.dart';

class HomeAdventStorybookCard extends StatelessWidget {
  final VoidCallback onOpenAdvent;

  const HomeAdventStorybookCard({super.key, required this.onOpenAdvent});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('home_advent_storybook_card'),
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
                width: 44,
                height: 44,
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
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.adventFeatureTitle,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2),
                    FestiveBadge(
                      label: AppStrings.adventActiveBadge,
                      backgroundColor: Color(0xFFDCFCE7),
                      textColor: AppColors.pineGreen,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceMD),
          const Text(
            AppStrings.adventFeatureDesc,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceMD),
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
    );
  }
}
