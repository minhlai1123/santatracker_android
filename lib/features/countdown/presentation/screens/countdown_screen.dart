import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/christmas_typography.dart';
import '../../../../shared/widgets/christmas_background.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../../../welcome/presentation/widgets/festive_badge.dart';
import '../../domain/models/countdown_state.dart';
import '../../domain/services/countdown_calculator.dart';
import '../widgets/countdown_display.dart';
import '../widgets/countdown_message_card.dart';
import '../widgets/home_screen_widget_card.dart';
import '../../../../core/services/christmas_widget_service.dart';

class CountdownScreen extends StatefulWidget {
  final DateTime Function()? clock;

  const CountdownScreen({super.key, this.clock});

  @override
  State<CountdownScreen> createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen>
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
    ChristmasWidgetService.updateWidget();
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
    final targetYear = _state.target.year;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.countdownScreenTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: AppStrings.backToHomeButton,
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
      ),
      body: ChristmasBackground(
        isDarkTheme: false,
        showSnowfall: true,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spaceLG,
                vertical: AppDimensions.spaceLG,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 540),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(targetYear),
                    const SizedBox(height: AppDimensions.spaceXL),
                    CountdownDisplay(state: _state),
                    const SizedBox(height: AppDimensions.spaceXL),
                    CountdownMessageCard(state: _state),
                    const SizedBox(height: AppDimensions.spaceXL),
                    HomeScreenWidgetCard(clock: widget.clock),
                    const SizedBox(height: AppDimensions.spaceXL),
                    FestiveButton(
                      label: AppStrings.backToHomeButton,
                      icon: Icons.home_rounded,
                      style: FestiveButtonStyle.outlined,
                      isExpanded: true,
                      onPressed: () {
                        Navigator.of(context).maybePop();
                      },
                    ),
                    const SizedBox(height: AppDimensions.spaceXL),
                    const Text(
                      AppStrings.holidayGreeting,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(int targetYear) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.festiveHeaderGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.christmasRed.withAlpha(50),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.hourglass_bottom_rounded,
              size: AppDimensions.iconSizeMD,
              color: AppColors.warmGold,
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceMD),
        Text(
          '${AppStrings.nextChristmasPrefix}$targetYear',
          textAlign: TextAlign.center,
          style: ChristmasTypography.titleLarge.copyWith(
            color: AppColors.christmasRed,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceSM),
        const FestiveBadge(
          label: AppStrings.offlineFirstBadge,
          icon: Icons.offline_bolt_rounded,
          iconColor: AppColors.pineGreen,
        ),
      ],
    );
  }
}
