import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/christmas_typography.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../../../welcome/presentation/widgets/festive_badge.dart';
import '../../domain/models/village_location.dart';

class VillageLocationDetailSheet extends StatelessWidget {
  final VillageLocation? location;
  final bool isDiscovered;
  final VoidCallback onDiscover;
  final VoidCallback onClose;

  const VillageLocationDetailSheet({
    super.key,
    required this.location,
    required this.isDiscovered,
    required this.onDiscover,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    if (location == null) {
      return Container(
        key: const Key('village_hint_card'),
        padding: const EdgeInsets.all(AppDimensions.spaceLG),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.touch_app_rounded,
              size: AppDimensions.iconSizeMD,
              color: AppColors.warmGold,
            ),
            SizedBox(width: AppDimensions.spaceMD),
            Expanded(
              child: Text(
                AppStrings.selectLocationHint,
                style: ChristmasTypography.bodyMedium,
              ),
            ),
          ],
        ),
      );
    }

    final loc = location!;

    return Container(
      key: const Key('village_location_detail_sheet'),
      padding: const EdgeInsets.all(AppDimensions.spaceLG),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        border: Border.all(
          color: isDiscovered
              ? AppColors.warmGold.withAlpha(120)
              : AppColors.cardBorder,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 16,
            offset: const Offset(0, 4),
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
                decoration: BoxDecoration(
                  color: isDiscovered ? AppColors.goldTint : AppColors.redTint,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  loc.type.icon,
                  size: AppDimensions.iconSizeMD,
                  color: isDiscovered
                      ? AppColors.warmGold
                      : AppColors.christmasRed,
                ),
              ),
              const SizedBox(width: AppDimensions.spaceMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            loc.name,
                            style: ChristmasTypography.titleMedium,
                          ),
                        ),
                        IconButton(
                          key: const Key('btn_close_location_sheet'),
                          icon: const Icon(Icons.close_rounded, size: 20),
                          color: AppColors.textMuted,
                          tooltip: AppStrings.closeDetailSheetButton,
                          onPressed: onClose,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Wrap(
                      spacing: AppDimensions.spaceSM,
                      runSpacing: 4,
                      children: [
                        FestiveBadge(
                          label: loc.type.label,
                          backgroundColor: const Color(0xFFF1F5F9),
                          textColor: AppColors.textSecondary,
                        ),
                        if (isDiscovered)
                          const FestiveBadge(
                            key: Key('badge_location_discovered'),
                            label: AppStrings.locationStatusDiscovered,
                            icon: Icons.check_circle_rounded,
                            backgroundColor: AppColors.greenTint,
                            textColor: AppColors.pineGreen,
                          )
                        else
                          const FestiveBadge(
                            key: Key('badge_location_undiscovered'),
                            label: AppStrings.locationStatusUndiscovered,
                            icon: Icons.explore_outlined,
                            backgroundColor: AppColors.goldTint,
                            textColor: Color(0xFF92400E),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceMD),
          Text(
            loc.description,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textPrimary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceSM),
          Container(
            padding: const EdgeInsets.all(AppDimensions.spaceMD),
            decoration: BoxDecoration(
              color: AppColors.softSnow,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.auto_awesome_rounded,
                  size: AppDimensions.iconSizeSM,
                  color: AppColors.warmGold,
                ),
                const SizedBox(width: AppDimensions.spaceSM),
                Expanded(
                  child: Text(
                    loc.details,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.spaceLG),
          if (!isDiscovered)
            FestiveButton(
              key: const Key('btn_discover_location'),
              label: AppStrings.discoverLocationButton,
              icon: Icons.explore_rounded,
              style: FestiveButtonStyle.primary,
              isExpanded: true,
              onPressed: onDiscover,
            )
          else
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spaceMD,
                vertical: AppDimensions.spaceMD,
              ),
              decoration: BoxDecoration(
                color: AppColors.greenTint,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: AppDimensions.iconSizeSM,
                    color: AppColors.pineGreen,
                  ),
                  SizedBox(width: AppDimensions.spaceSM),
                  Expanded(
                    child: Text(
                      'This location is already part of your exploration journey',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.pineGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
