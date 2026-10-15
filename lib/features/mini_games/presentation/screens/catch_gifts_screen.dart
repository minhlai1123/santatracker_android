import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../controllers/catch_gifts_controller.dart';
import '../controllers/mini_games_controller.dart';
import '../widgets/catch_gift_target_widget.dart';

class CatchGiftsScreen extends StatefulWidget {
  final CatchGiftsController? controller;
  final MiniGamesController? statsController;

  const CatchGiftsScreen({super.key, this.controller, this.statsController});

  @override
  State<CatchGiftsScreen> createState() => _CatchGiftsScreenState();
}

class _CatchGiftsScreenState extends State<CatchGiftsScreen> {
  late final CatchGiftsController _controller;
  late final MiniGamesController _statsController;
  late final bool _internalController;
  late final bool _internalStatsController;

  @override
  void initState() {
    super.initState();
    if (widget.statsController != null) {
      _statsController = widget.statsController!;
      _internalStatsController = false;
    } else {
      _statsController = MiniGamesController();
      _internalStatsController = true;
      _statsController.initialize();
    }

    if (widget.controller != null) {
      _controller = widget.controller!;
      _internalController = false;
    } else {
      _controller = CatchGiftsController(statsController: _statsController);
      _internalController = true;
    }
  }

  @override
  void dispose() {
    if (_internalController) {
      _controller.dispose();
    }
    if (_internalStatsController) {
      _statsController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.catchGiftsTitle),
        actions: [
          IconButton(
            key: const Key('btn_reset_catch_gifts'),
            icon: const Icon(Icons.refresh_rounded),
            tooltip: AppStrings.replayGameButton,
            onPressed: () => _controller.reset(),
          ),
        ],
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: Listenable.merge([_controller, _statsController]),
          builder: (context, _) {
            final state = _controller.state;
            final record = _statsController.record;

            return Column(
              children: [
                // Top Stats Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spaceLG,
                    vertical: AppDimensions.spaceSM,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spaceMD,
                      vertical: AppDimensions.spaceSM,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMD,
                      ),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatColumn(
                          label: AppStrings.scoreLabel,
                          value: '${state.score}',
                          color: AppColors.christmasRed,
                        ),
                        _buildDivider(),
                        _buildStatColumn(
                          label: AppStrings.timeRemainingLabel,
                          value: '${state.remainingSeconds}s',
                          color: state.remainingSeconds <= 5
                              ? AppColors.christmasRed
                              : AppColors.pineGreen,
                        ),
                        _buildDivider(),
                        _buildStatColumn(
                          label: AppStrings.highScoreLabel,
                          value: '${record.catchGiftsHighScore}',
                          color: AppColors.warmGold,
                        ),
                      ],
                    ),
                  ),
                ),

                // Main Play Arena
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimensions.spaceLG,
                      0,
                      AppDimensions.spaceLG,
                      AppDimensions.spaceLG,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusLG,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusLG,
                          ),
                          border: Border.all(
                            color: AppColors.cardBorder,
                            width: 1.5,
                          ),
                        ),
                        child: _buildPlayAreaContent(state),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlayAreaContent(dynamic state) {
    if (!state.isPlaying && !state.isGameOver) {
      // Intro state before starting
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.spaceLG),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.christmasRed.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.card_giftcard_rounded,
                  size: 40,
                  color: AppColors.christmasRed,
                ),
              ),
              const SizedBox(height: AppDimensions.spaceMD),
              const Text(
                AppStrings.catchGiftsTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimensions.spaceSM),
              const Text(
                AppStrings.catchGiftsInstructions,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: AppDimensions.spaceLG),
              FestiveButton(
                key: const Key('btn_start_catch_gifts'),
                label: AppStrings.playGameButton,
                icon: Icons.play_arrow_rounded,
                style: FestiveButtonStyle.primary,
                onPressed: () => _controller.startGame(),
              ),
            ],
          ),
        ),
      );
    }

    if (state.isGameOver) {
      // Game Over Screen
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.spaceLG),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.warmGold.withAlpha(35),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  size: 40,
                  color: AppColors.warmGold,
                ),
              ),
              const SizedBox(height: AppDimensions.spaceMD),
              const Text(
                AppStrings.catchGiftsGameOverTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimensions.spaceXS),
              const Text(
                AppStrings.catchGiftsGameOverMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
              const SizedBox(height: AppDimensions.spaceMD),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spaceLG,
                  vertical: AppDimensions.spaceMD,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        const Text(
                          AppStrings.scoreLabel,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '${state.score}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.christmasRed,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: AppDimensions.spaceXL),
                    Column(
                      children: [
                        const Text(
                          AppStrings.totalGiftsLabel,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          '${state.totalGiftsCaught}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.pineGreen,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.spaceLG),
              FestiveButton(
                key: const Key('btn_replay_catch_gifts'),
                label: AppStrings.replayGameButton,
                icon: Icons.replay_rounded,
                style: FestiveButtonStyle.primary,
                onPressed: () => _controller.startGame(),
              ),
            ],
          ),
        ),
      );
    }

    // Active gameplay canvas
    return LayoutBuilder(
      builder: (context, constraints) {
        final double usableWidth = (constraints.maxWidth - 56).clamp(
          0.0,
          double.infinity,
        );
        final double usableHeight = (constraints.maxHeight - 56).clamp(
          0.0,
          double.infinity,
        );

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _controller.tapEmptyArea(),
          child: Stack(
            children: [
              // Snowflakes / winter ambience hint
              Positioned(
                bottom: 8,
                left: 12,
                child: Text(
                  'Bắt các hộp quà đang rơi!',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted.withAlpha(160),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              // Targets
              for (final gift in state.activeGifts)
                Positioned(
                  left: gift.normalizedX * usableWidth,
                  top: gift.normalizedY * usableHeight,
                  child: CatchGiftTargetWidget(
                    key: Key('gift_target_${gift.id}'),
                    gift: gift,
                    onTap: () => _controller.tapGift(gift.id),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatColumn({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(height: 28, width: 1, color: AppColors.cardBorder);
  }
}
