import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';

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
        color: isHighlight ? AppColors.redTint : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
        border: Border.all(
          color: isHighlight
              ? AppColors.christmasRed.withAlpha(80)
              : AppColors.cardBorder,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(6),
            blurRadius: 10,
            offset: const Offset(0, 3),
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
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: isHighlight
                    ? AppColors.christmasRed
                    : AppColors.textPrimary,
                height: 1.1,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceXS),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
