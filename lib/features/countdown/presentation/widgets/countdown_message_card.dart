import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/christmas_typography.dart';
import '../../domain/models/countdown_message_type.dart';
import '../../domain/models/countdown_state.dart';

class CountdownMessageCard extends StatelessWidget {
  final CountdownState state;

  const CountdownMessageCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    IconData messageIcon;
    Color iconColor;
    Color backgroundColor;
    Color borderColor;

    switch (state.messageType) {
      case CountdownMessageType.christmasDay:
        messageIcon = Icons.celebration_rounded;
        iconColor = AppColors.warmGold;
        backgroundColor = AppColors.goldTint;
        borderColor = AppColors.warmGold.withAlpha(100);
        break;
      case CountdownMessageType.under24Hours:
        messageIcon = Icons.bolt_rounded;
        iconColor = AppColors.christmasRed;
        backgroundColor = AppColors.redTint;
        borderColor = AppColors.christmasRed.withAlpha(80);
        break;
      case CountdownMessageType.oneToSevenDays:
        messageIcon = Icons.auto_awesome_rounded;
        iconColor = AppColors.christmasRed;
        backgroundColor = AppColors.redTint;
        borderColor = AppColors.cardBorder;
        break;
      case CountdownMessageType.eightToThirtyDays:
        messageIcon = Icons.card_giftcard_rounded;
        iconColor = AppColors.pineGreen;
        backgroundColor = AppColors.greenTint;
        borderColor = AppColors.cardBorder;
        break;
      case CountdownMessageType.overThirtyDays:
        messageIcon = Icons.calendar_month_rounded;
        iconColor = AppColors.pineGreen;
        backgroundColor = AppColors.surfaceLight;
        borderColor = AppColors.cardBorder;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceLG),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(6),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state.isChristmasDay) ...[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spaceMD,
                vertical: AppDimensions.spaceXS,
              ),
              decoration: BoxDecoration(
                color: AppColors.christmasRed,
                borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star_rounded,
                    size: AppDimensions.iconSizeSM,
                    color: AppColors.warmGold,
                  ),
                  const SizedBox(width: AppDimensions.spaceXS),
                  Text(
                    AppStrings.christmasDayBadge,
                    style: ChristmasTypography.badgeLabel.copyWith(
                      color: AppColors.snowWhite,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.spaceMD),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.spaceSM),
                decoration: BoxDecoration(
                  color: iconColor.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  messageIcon,
                  size: AppDimensions.iconSizeMD,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: AppDimensions.spaceMD),
              Expanded(
                child: Text(
                  state.message,
                  style: ChristmasTypography.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
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
