import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';

class SantaOfflineBanner extends StatelessWidget {
  final bool isOffline;

  const SantaOfflineBanner({super.key, required this.isOffline});

  @override
  Widget build(BuildContext context) {
    if (!isOffline) {
      return const SizedBox.shrink();
    }

    return Container(
      key: const Key('santa_offline_banner'),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceMD,
        vertical: AppDimensions.spaceSM,
      ),
      decoration: BoxDecoration(
        color: AppColors.goldTint,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        border: Border.all(color: AppColors.warmGold.withAlpha(120)),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.cloud_off_rounded,
            size: AppDimensions.iconSizeSM,
            color: AppColors.pineGreen,
          ),
          SizedBox(width: AppDimensions.spaceSM),
          Expanded(
            child: Text(
              AppStrings.offlineSimulationBanner,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
