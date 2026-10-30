import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';

import '../../../../core/theme/christmas_typography.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppDimensions.headerCircleSize,
          height: AppDimensions.headerCircleSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.festiveHeaderGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.christmasRed.withAlpha(50),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.star_rounded,
              size: AppDimensions.iconSizeLG,
              color: AppColors.warmGold,
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceLG),
        Text(
          AppStrings.appName,
          textAlign: TextAlign.center,
          style: ChristmasTypography.displayLarge.copyWith(
            color: AppColors.christmasRed,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceSM),
        Text(
          AppStrings.festiveTagline,
          textAlign: TextAlign.center,
          style: ChristmasTypography.titleSmall.copyWith(
            color: AppColors.pineGreen,
          ),
        ),
      ],
    );
  }
}
