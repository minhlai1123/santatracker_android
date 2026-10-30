import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/services/christmas_audio_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/christmas_typography.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../../../countdown/domain/models/countdown_state.dart';
import '../../../countdown/domain/services/countdown_calculator.dart';
import '../../../countdown/presentation/widgets/countdown_display.dart';

class HomeCountdownPreviewCard extends StatefulWidget {
  final VoidCallback onOpenCountdown;
  final DateTime Function()? clock;

  const HomeCountdownPreviewCard({
    super.key,
    required this.onOpenCountdown,
    this.clock,
  });

  @override
  State<HomeCountdownPreviewCard> createState() =>
      _HomeCountdownPreviewCardState();
}

class _HomeCountdownPreviewCardState extends State<HomeCountdownPreviewCard>
    with WidgetsBindingObserver {
  Timer? _timer;
  late CountdownState _state;

  DateTime _now() => widget.clock?.call() ?? DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _state = CountdownCalculator.calculate(_now());
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      _updateCountdown();
    });
  }

  void _updateCountdown() {
    final newState = CountdownCalculator.calculate(_now());
    if (newState != _state && mounted) {
      setState(() {
        _state = newState;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _updateCountdown();
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        ChristmasAudioService.playButtonClick();
        widget.onOpenCountdown();
      },
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.spaceLG),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          border: Border.all(
            color: AppColors.warmGold.withAlpha(90),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0A1830).withAlpha(16),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: AppColors.christmasRed.withAlpha(12),
              blurRadius: 24,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: AppColors.festiveHeaderGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.christmasRed.withAlpha(50),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.timer_outlined,
                    size: 26,
                    color: AppColors.candlelight,
                  ),
                ),
                const SizedBox(width: AppDimensions.spaceMD),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.countdownPreviewTitle,
                        style: ChristmasTypography.titleLarge,
                      ),
                      SizedBox(height: AppDimensions.spaceXS),
                      Text(
                        AppStrings.countdownPreviewSubtitle,
                        style: ChristmasTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceLG),
            CountdownDisplay(state: _state),
            const SizedBox(height: AppDimensions.spaceMD),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spaceMD,
                vertical: AppDimensions.spaceSM,
              ),
              decoration: BoxDecoration(
                color: AppColors.softSnow,
                borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.tips_and_updates_rounded,
                    size: AppDimensions.iconSizeSM,
                    color: AppColors.warmGold,
                  ),
                  const SizedBox(width: AppDimensions.spaceSM),
                  Expanded(
                    child: Text(
                      _state.message,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.spaceLG),
            FestiveButton(
              label: AppStrings.openCountdownButton,
              icon: Icons.timer_rounded,
              isExpanded: true,
              onPressed: widget.onOpenCountdown,
            ),
          ],
        ),
      ),
    );
  }
}
