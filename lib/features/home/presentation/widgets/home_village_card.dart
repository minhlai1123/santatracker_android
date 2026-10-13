import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../../../welcome/presentation/widgets/festive_badge.dart';

class HomeVillageCard extends StatelessWidget {
  final VoidCallback onOpenVillage;

  const HomeVillageCard({super.key, required this.onOpenVillage});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('home_village_card'),
      padding: const EdgeInsets.all(AppDimensions.spaceLG),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        border: Border.all(color: AppColors.warmGold.withAlpha(90), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.warmGold.withAlpha(20),
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
                  color: AppColors.goldTint,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.holiday_village_rounded,
                  size: AppDimensions.iconSizeMD,
                  color: AppColors.warmGold,
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
                            AppStrings.villageFeatureTitle,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        FestiveBadge(
                          label: AppStrings.villageActiveBadge,
                          backgroundColor: AppColors.goldTint,
                          textColor: Color(0xFF92400E),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimensions.spaceXS),
                    Text(
                      AppStrings.villageFeatureDesc,
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
            key: const Key('btn_open_village'),
            label: AppStrings.openVillageButton,
            icon: Icons.explore_rounded,
            style: FestiveButtonStyle.primary,
            isExpanded: true,
            onPressed: onOpenVillage,
          ),
        ],
      ),
    );
  }
}
