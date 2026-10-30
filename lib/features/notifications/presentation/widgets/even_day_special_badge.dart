import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/christmas_typography.dart';

class EvenDaySpecialBadge extends StatelessWidget {
  final bool isCompact;

  const EvenDaySpecialBadge({super.key, this.isCompact = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? AppDimensions.spaceSM : AppDimensions.spaceMD,
        vertical: isCompact ? 3.0 : AppDimensions.spaceXS,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF59E0B), Color(0xFFD97706), Color(0xFFB45309)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF59E0B).withAlpha(90),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: const Color(0xFFFEF08A), width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.auto_awesome_rounded,
            size: 14,
            color: Color(0xFFFEF08A),
          ),
          const SizedBox(width: AppDimensions.spaceXS),
          Text(
            AppStrings.evenDaySpecialBadge.toUpperCase(),
            style: TextStyle(
              fontFamily: ChristmasTypography.fontFamilyUI,
              fontFamilyFallback: ChristmasTypography.fallbackFonts,
              fontSize: isCompact ? 10 : 11,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}
