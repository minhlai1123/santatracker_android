import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../controllers/memory_match_controller.dart';
import '../controllers/mini_games_controller.dart';
import '../widgets/memory_card_widget.dart';

class MemoryMatchScreen extends StatefulWidget {
  final MemoryMatchController? controller;
  final MiniGamesController? statsController;

  const MemoryMatchScreen({super.key, this.controller, this.statsController});

  @override
  State<MemoryMatchScreen> createState() => _MemoryMatchScreenState();
}

class _MemoryMatchScreenState extends State<MemoryMatchScreen> {
  late final MemoryMatchController _controller;
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
      _controller = MemoryMatchController(statsController: _statsController);
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
        title: const Text(AppStrings.memoryMatchTitle),
        actions: [
          IconButton(
            key: const Key('btn_reset_memory_match'),
            icon: const Icon(Icons.refresh_rounded),
            tooltip: AppStrings.replayGameButton,
            onPressed: () => _controller.reset(),
          ),
        ],
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final state = _controller.state;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spaceLG,
                  vertical: AppDimensions.spaceMD,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header Stats Panel
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.spaceLG,
                          vertical: AppDimensions.spaceMD,
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
                            Column(
                              children: [
                                const Text(
                                  AppStrings.movesLabel,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${state.moves}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.christmasRed,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 32,
                              width: 1,
                              color: AppColors.cardBorder,
                            ),
                            Column(
                              children: [
                                const Text(
                                  AppStrings.pairsFoundLabel,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${state.matchedPairCount} / ${state.totalPairs}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.pineGreen,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spaceMD),

                      // Win Banner (if completed)
                      if (state.isCompleted) ...[
                        Container(
                          padding: const EdgeInsets.all(AppDimensions.spaceMD),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCFCE7),
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusMD,
                            ),
                            border: Border.all(color: AppColors.pineGreen),
                          ),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.celebration_rounded,
                                    color: AppColors.pineGreen,
                                    size: 24,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    AppStrings.memoryMatchWinTitle,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.pineGreen,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                AppStrings.memoryMatchWinMessage,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: AppDimensions.spaceMD),
                              FestiveButton(
                                key: const Key('btn_replay_memory_match'),
                                label: AppStrings.replayGameButton,
                                icon: Icons.replay_rounded,
                                style: FestiveButtonStyle.primary,
                                onPressed: () => _controller.reset(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spaceMD),
                      ],

                      // Card Grid: 3 columns x 4 rows
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.cards.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.95,
                            ),
                        itemBuilder: (context, index) {
                          final card = state.cards[index];
                          return MemoryCardWidget(
                            key: Key('memory_card_$index'),
                            card: card,
                            onTap: () => _controller.flipCard(index),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
