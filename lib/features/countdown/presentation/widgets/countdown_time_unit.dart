import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/christmas_typography.dart';

class CountdownTimeUnit extends StatelessWidget {
  final String value;
  final String label;
  final bool isHighlight;

  const CountdownTimeUnit({
    super.key,
    required this.value,
    required this.label,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceSM,
        vertical: AppDimensions.spaceMD,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isHighlight
              ? [const Color(0xFFFFF5F5), const Color(0xFFFEE8E8)]
              : [const Color(0xFFFFFFFF), const Color(0xFFF6F9FD)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        border: Border.all(
          color: isHighlight
              ? AppColors.christmasRed.withAlpha(120)
              : AppColors.warmGold.withAlpha(80),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isHighlight
                ? AppColors.christmasRed.withAlpha(25)
                : const Color(0xFF0F1E36).withAlpha(14),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          const BoxShadow(
            color: Colors.white,
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: ChristmasTypography.countdownDigit.copyWith(
                color: isHighlight
                    ? AppColors.christmasRed
                    : AppColors.textPrimary,
                fontWeight: FontWeight.w900,
                shadows: [
                  Shadow(
                    color: (isHighlight ? AppColors.christmasRed : Colors.black)
                        .withAlpha(30),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceXS),
          Text(
            label,
            textAlign: TextAlign.center,
            style: ChristmasTypography.badgeLabel.copyWith(
              color: isHighlight
                  ? AppColors.christmasRed
                  : AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
