import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/christmas_typography.dart';

class FestiveBadge extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;
  final Color? iconColor;

  const FestiveBadge({
    super.key,
    required this.label,
    this.icon,
    this.backgroundColor = const Color(0xFFF1F5F9),
    this.textColor = AppColors.textSecondary,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceMD,
        vertical: AppDimensions.spaceSM,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: AppDimensions.iconSizeSM,
              color: iconColor ?? textColor,
            ),
            const SizedBox(width: AppDimensions.spaceSM),
          ],
          Flexible(
            child: Text(
              label,
              style: ChristmasTypography.badgeLabel.copyWith(color: textColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
