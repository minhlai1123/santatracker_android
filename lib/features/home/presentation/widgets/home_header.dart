import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../welcome/presentation/widgets/festive_badge.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.festiveHeaderGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.christmasRed.withAlpha(50),
                blurRadius: 18,
                offset: const Offset(0, 6),
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
        const SizedBox(height: AppDimensions.spaceMD),
        const Text(
          AppStrings.appName,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceXS),
        const Text(
          AppStrings.homeGreetingPrefix,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.pineGreen,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceSM),
        const FestiveBadge(
          label: AppStrings.festiveTagline,
          icon: Icons.ac_unit_rounded,
          iconColor: AppColors.christmasRed,
        ),
      ],
    );
  }
}
