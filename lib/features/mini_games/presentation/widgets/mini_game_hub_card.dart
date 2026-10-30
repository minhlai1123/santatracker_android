import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/christmas_typography.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../../../welcome/presentation/widgets/festive_badge.dart';

class MiniGameHubCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final List<String> statsHighlights;
  final VoidCallback onPlay;
  final Key? playButtonKey;

  const MiniGameHubCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.statsHighlights,
    required this.onPlay,
    this.playButtonKey,
  });

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
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.christmasRed.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: AppDimensions.iconSizeMD,
                  color: AppColors.christmasRed,
                ),
              ),
              const SizedBox(width: AppDimensions.spaceMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: ChristmasTypography.titleLarge),
                    const SizedBox(height: 2),
                    const FestiveBadge(
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
          Text(description, style: ChristmasTypography.bodyMedium),
          if (statsHighlights.isNotEmpty) ...[
            const SizedBox(height: AppDimensions.spaceMD),
            Wrap(
              spacing: AppDimensions.spaceSM,
              runSpacing: AppDimensions.spaceXS,
              children: statsHighlights.map((stat) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spaceSM,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.pineGreen.withAlpha(15),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                  ),
                  child: Text(
                    stat,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.pineGreen,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: AppDimensions.spaceLG),
          FestiveButton(
            key: playButtonKey,
            label: AppStrings.playGameButton,
            icon: Icons.play_arrow_rounded,
            style: FestiveButtonStyle.primary,
            isExpanded: true,
            onPressed: onPlay,
          ),
        ],
      ),
    );
  }
}
