import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/santa_tracker_state.dart';

class SantaControlPanel extends StatelessWidget {
  final SantaTrackerState state;
  final VoidCallback onStart;
  final VoidCallback onNextStop;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onReset;

  const SantaControlPanel({
    super.key,
    required this.state,
    required this.onStart,
    required this.onNextStop,
    required this.onPause,
    required this.onResume,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final isPaused = state.isPaused;

    return Container(
      key: const Key('santa_control_panel'),
      padding: const EdgeInsets.all(AppDimensions.spaceLG),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            children: [
              Icon(
                Icons.gamepad_outlined,
                size: AppDimensions.iconSizeMD,
                color: AppColors.pineGreen,
              ),
              SizedBox(width: AppDimensions.spaceSM),
              Expanded(
                child: Text(
                  AppStrings.controlPanelTitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceMD),
          ElevatedButton.icon(
            key: const Key('btn_start_journey'),
            onPressed: state.canStart ? onStart : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.christmasRed,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spaceMD,
                vertical: 12,
              ),
            ),
            icon: const Icon(Icons.play_arrow_rounded, size: 20),
            label: const Text(
              AppStrings.startJourneyButton,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceSM),
          ElevatedButton.icon(
            key: const Key('btn_next_stop'),
            onPressed: state.canAdvance ? onNextStop : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.pineGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spaceMD,
                vertical: 12,
              ),
            ),
            icon: const Icon(Icons.skip_next_rounded, size: 20),
            label: const Text(
              AppStrings.nextStopButton,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceSM),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  key: const Key('btn_pause_resume_journey'),
                  onPressed: isPaused
                      ? (state.canResume ? onResume : null)
                      : (state.canPause ? onPause : null),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.pineGreen,
                    side: BorderSide(
                      color: (state.canPause || state.canResume)
                          ? AppColors.pineGreen
                          : AppColors.cardBorder,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spaceSM,
                      vertical: 12,
                    ),
                  ),
                  icon: Icon(
                    isPaused ? Icons.play_circle_outline : Icons.pause_rounded,
                    size: 18,
                  ),
                  label: Text(
                    isPaused
                        ? AppStrings.resumeJourneyButton
                        : AppStrings.pauseJourneyButton,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.spaceSM),
              Expanded(
                child: OutlinedButton.icon(
                  key: const Key('btn_reset_journey'),
                  onPressed: state.canReset ? onReset : null,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.christmasRed,
                    side: BorderSide(
                      color: state.canReset
                          ? AppColors.christmasRed
                          : AppColors.cardBorder,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spaceSM,
                      vertical: 12,
                    ),
                  ),
                  icon: const Icon(Icons.restart_alt_rounded, size: 18),
                  label: const Text(
                    AppStrings.resetJourneyButton,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
