import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/falling_gift.dart';

class CatchGiftTargetWidget extends StatelessWidget {
  final FallingGift gift;
  final VoidCallback onTap;

  const CatchGiftTargetWidget({
    super.key,
    required this.gift,
    required this.onTap,
  });

  Color _getGiftColor(int seed) {
    switch (seed % 4) {
      case 0:
        return AppColors.christmasRed;
      case 1:
        return AppColors.pineGreen;
      case 2:
        return AppColors.warmGold;
      case 3:
      default:
        return const Color(0xFF1E3A8A); // Royal Navy
    }
  }

  @override
  Widget build(BuildContext context) {
    final giftColor = _getGiftColor(gift.colorSeed);

    return Semantics(
      button: true,
      label: 'Hộp quà ${gift.points} điểm',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: giftColor,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
            boxShadow: [
              BoxShadow(
                color: giftColor.withAlpha(90),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(color: Colors.white.withAlpha(200), width: 1.5),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                Icons.card_giftcard_rounded,
                size: 32,
                color: Colors.white,
              ),
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(220),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '+${gift.points}',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: giftColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
