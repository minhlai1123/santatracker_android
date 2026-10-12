import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../welcome/presentation/widgets/festive_badge.dart';

class HomeComingSoonSection extends StatelessWidget {
  const HomeComingSoonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.comingSoonTitle,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceXS),
        const Text(
          AppStrings.comingSoonSubtitle,
          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppDimensions.spaceMD),
        _buildFeatureCard(
          icon: Icons.explore_outlined,
          title: AppStrings.trackerFeatureTitle,
          description: AppStrings.trackerFeatureDesc,
        ),
        const SizedBox(height: AppDimensions.spaceSM),
        _buildFeatureCard(
          icon: Icons.holiday_village_outlined,
          title: AppStrings.villageFeatureTitle,
          description: AppStrings.villageFeatureDesc,
        ),
        const SizedBox(height: AppDimensions.spaceSM),
        _buildFeatureCard(
          icon: Icons.sports_esports_outlined,
          title: AppStrings.gamesFeatureTitle,
          description: AppStrings.gamesFeatureDesc,
        ),
        const SizedBox(height: AppDimensions.spaceSM),
        _buildFeatureCard(
          icon: Icons.calendar_month_outlined,
          title: AppStrings.adventFeatureTitle,
          description: AppStrings.adventFeatureDesc,
        ),
      ],
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceMD),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.spaceSM),
            decoration: BoxDecoration(
              color: AppColors.pineGreen.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: AppDimensions.iconSizeMD,
              color: AppColors.pineGreen,
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
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const FestiveBadge(
                      label: AppStrings.comingSoonBadge,
                      backgroundColor: Color(0xFFF1F5F9),
                      textColor: AppColors.textMuted,
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.spaceXS),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.4,
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
