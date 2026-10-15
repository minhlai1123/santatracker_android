import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/memory_card.dart';

class MemoryCardWidget extends StatelessWidget {
  final MemoryCard card;
  final VoidCallback onTap;

  const MemoryCardWidget({super.key, required this.card, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isRevealed = card.isFlipped || card.isMatched;

    return Semantics(
      button: true,
      label: isRevealed
          ? '${card.name}${card.isMatched ? ' đã ghép' : ''}'
          : 'Thẻ chưa lật',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isRevealed ? null : onTap,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: isRevealed
                  ? (card.isMatched
                        ? AppColors.pineGreen.withAlpha(25)
                        : AppColors.christmasRed.withAlpha(20))
                  : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
              border: Border.all(
                color: isRevealed
                    ? (card.isMatched
                          ? AppColors.pineGreen
                          : AppColors.christmasRed)
                    : AppColors.cardBorder,
                width: isRevealed ? 2.0 : 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(6),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: isRevealed
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          card.icon,
                          size: 32,
                          color: card.isMatched
                              ? AppColors.pineGreen
                              : AppColors.christmasRed,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          card.name,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: card.isMatched
                                ? AppColors.pineGreen
                                : AppColors.christmasRed,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.ac_unit_rounded,
                          size: 26,
                          color: AppColors.warmGold,
                        ),
                        SizedBox(height: 2),
                        Text(
                          '?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.warmGold,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
