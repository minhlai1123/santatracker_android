import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';
import '../../core/theme/app_colors.dart';

/// A reusable festive card with holiday borders, subtle depth, and smooth corners.
class ChristmasCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final List<BoxShadow>? customShadow;
  final VoidCallback? onTap;

  const ChristmasCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppDimensions.spaceLG),
    this.margin,
    this.backgroundColor = AppColors.surfaceLight,
    this.borderColor,
    this.borderWidth = 1.5,
    this.customShadow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = borderColor ?? AppColors.cardBorder;

    final cardWidget = Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        border: Border.all(color: effectiveBorderColor, width: borderWidth),
        boxShadow:
            customShadow ??
            [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: AppColors.christmasRed.withAlpha(10),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        child: cardWidget,
      );
    }

    return cardWidget;
  }
}
