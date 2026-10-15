import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../../../welcome/presentation/widgets/festive_badge.dart';

class HomeMiniGamesCard extends StatelessWidget {
  final VoidCallback onOpenMiniGames;

  const HomeMiniGamesCard({super.key, required this.onOpenMiniGames});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('home_mini_games_card'),
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
                  color: AppColors.pineGreen.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.sports_esports_rounded,
                  size: AppDimensions.iconSizeMD,
                  color: AppColors.pineGreen,
                ),
              ),
              const SizedBox(width: AppDimensions.spaceMD),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.gamesFeatureTitle,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2),
                    FestiveBadge(
                      label: AppStrings.miniGamesActiveBadge,
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
            AppStrings.gamesFeatureDesc,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceMD),
          FestiveButton(
            key: const Key('btn_open_mini_games'),
            label: AppStrings.openMiniGamesButton,
            icon: Icons.sports_esports_rounded,
            style: FestiveButtonStyle.primary,
            isExpanded: true,
            onPressed: onOpenMiniGames,
          ),
        ],
      ),
    );
  }
}
