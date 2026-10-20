import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/christmas_typography.dart';
import '../../domain/models/santa_journey_status.dart';
import '../../domain/models/santa_tracker_state.dart';

class SantaJourneyInfoCard extends StatelessWidget {
  final SantaTrackerState state;

  const SantaJourneyInfoCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('santa_journey_info_card'),
      padding: const EdgeInsets.all(AppDimensions.spaceLG),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.spaceSM),
                decoration: const BoxDecoration(
                  color: AppColors.redTint,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.explore_rounded,
                  size: AppDimensions.iconSizeMD,
                  color: AppColors.christmasRed,
                ),
              ),
              const SizedBox(width: AppDimensions.spaceMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      AppStrings.infoCardTitle,
                      style: ChristmasTypography.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${AppStrings.routeProgressLabel}: ${state.progressFractionDisplay}',
                      key: const Key('info_route_progress'),
                      style: ChristmasTypography.badgeLabel.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusPill(state.status),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceMD),
          Container(
            padding: const EdgeInsets.all(AppDimensions.spaceMD),
            decoration: BoxDecoration(
              color: AppColors.softSnow,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: Text(
              state.currentStop.description,
              key: const Key('info_current_stop_description'),
              style: ChristmasTypography.bodyMedium,
            ),
          ),
          if (state.isCompleted) ...[
            const SizedBox(height: AppDimensions.spaceMD),
            Container(
              key: const Key('journey_completed_banner'),
              padding: const EdgeInsets.all(AppDimensions.spaceMD),
              decoration: BoxDecoration(
                color: AppColors.greenTint,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                border: Border.all(color: AppColors.pineGreen.withAlpha(80)),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.celebration_rounded,
                    size: AppDimensions.iconSizeMD,
                    color: AppColors.pineGreen,
                  ),
                  SizedBox(width: AppDimensions.spaceSM),
                  Expanded(
                    child: Text(
                      AppStrings.journeyCompletedBanner,
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
          const SizedBox(height: AppDimensions.spaceMD),
          _buildInfoRow(
            icon: Icons.place_rounded,
            iconColor: AppColors.christmasRed,
            label: AppStrings.currentLocationLabel,
            value: state.currentLocationDisplay,
            valueKey: const Key('info_current_location_value'),
          ),
          const Divider(height: AppDimensions.spaceLG),
          _buildInfoRow(
            icon: Icons.flag_rounded,
            iconColor: AppColors.pineGreen,
            label: AppStrings.nextDestinationLabel,
            value: state.nextDestinationDisplay,
            valueKey: const Key('info_next_destination_value'),
          ),
          const Divider(height: AppDimensions.spaceLG),
          _buildInfoRow(
            icon: Icons.info_outline_rounded,
            iconColor: AppColors.pineGreen,
            label: AppStrings.journeyStatusLabel,
            value: state.status.label,
            valueKey: const Key('info_journey_status_value'),
          ),
          const Divider(height: AppDimensions.spaceLG),
          _buildInfoRow(
            icon: Icons.card_giftcard_rounded,
            iconColor: AppColors.warmGold,
            label: AppStrings.giftsDeliveredLabel,
            value: state.giftsDeliveredDisplay,
            valueKey: const Key('info_gifts_delivered_value'),
          ),
          const Divider(height: AppDimensions.spaceLG),
          _buildInfoRow(
            icon: Icons.schedule_rounded,
            iconColor: AppColors.christmasRed,
            label: AppStrings.simulatedEtaLabel,
            value: state.etaDisplay,
            valueKey: const Key('info_simulated_eta_value'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusPill(SantaJourneyStatus status) {
    final Color bgColor;
    final Color textColor;

    switch (status) {
      case SantaJourneyStatus.notStarted:
        bgColor = const Color(0xFFF1F5F9);
        textColor = AppColors.textSecondary;
      case SantaJourneyStatus.inProgress:
        bgColor = AppColors.redTint;
        textColor = AppColors.christmasRed;
      case SantaJourneyStatus.paused:
        bgColor = AppColors.goldTint;
        textColor = const Color(0xFF92400E);
      case SantaJourneyStatus.completed:
        bgColor = AppColors.greenTint;
        textColor = AppColors.pineGreen;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceSM,
        vertical: AppDimensions.spaceXS,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required Key valueKey,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: AppDimensions.iconSizeMD, color: iconColor),
        const SizedBox(width: AppDimensions.spaceSM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: ChristmasTypography.bodySmall),
              const SizedBox(height: 2),
              Text(value, key: valueKey, style: ChristmasTypography.titleSmall),
            ],
          ),
        ),
      ],
    );
  }
}
