import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';
import '../../core/services/christmas_audio_service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/christmas_typography.dart';

enum FestiveButtonStyle { primary, secondary, outlined }

class FestiveButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final FestiveButtonStyle style;
  final bool isExpanded;

  const FestiveButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.style = FestiveButtonStyle.primary,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color foregroundColor;
    BorderSide? side;

    switch (style) {
      case FestiveButtonStyle.primary:
        backgroundColor = AppColors.christmasRed;
        foregroundColor = AppColors.snowWhite;
        side = BorderSide.none;
        break;
      case FestiveButtonStyle.secondary:
        backgroundColor = AppColors.pineGreen;
        foregroundColor = AppColors.snowWhite;
        side = BorderSide.none;
        break;
      case FestiveButtonStyle.outlined:
        backgroundColor = AppColors.surfaceLight;
        foregroundColor = AppColors.pineGreen;
        side = const BorderSide(color: AppColors.cardBorder, width: 1.5);
        break;
    }

    final buttonContent = Row(
      mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: AppDimensions.iconSizeMD),
          const SizedBox(width: AppDimensions.spaceSM),
        ],
        Flexible(
          child: Text(
            label,
            style: ChristmasTypography.buttonLabel.copyWith(
              color: foregroundColor,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );

    return SizedBox(
      height: 50,
      width: isExpanded ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed == null
            ? null
            : () {
                ChristmasAudioService.playButtonClick();
                onPressed!();
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          side: side,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spaceMD,
            vertical: AppDimensions.spaceSM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          ),
        ),
        child: buttonContent,
      ),
    );
  }
}
