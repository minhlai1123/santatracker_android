import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/mini_games_controller.dart';
import '../widgets/mini_game_hub_card.dart';
import 'catch_gifts_screen.dart';
import 'memory_match_screen.dart';

class ChristmasMiniGamesScreen extends StatefulWidget {
  final MiniGamesController? controller;

  const ChristmasMiniGamesScreen({super.key, this.controller});

  @override
  State<ChristmasMiniGamesScreen> createState() =>
      _ChristmasMiniGamesScreenState();
}

class _ChristmasMiniGamesScreenState extends State<ChristmasMiniGamesScreen> {
  late final MiniGamesController _controller;
  late final bool _internalController;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
      _internalController = false;
    } else {
      _controller = MiniGamesController();
      _internalController = true;
      _controller.initialize();
    }
  }

  @override
  void dispose() {
    if (_internalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _navigateToMemoryMatch(BuildContext context) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (_) => MemoryMatchScreen(statsController: _controller),
          ),
        )
        .then((_) {
          if (mounted) setState(() {});
        });
  }

  void _navigateToCatchGifts(BuildContext context) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (_) => CatchGiftsScreen(statsController: _controller),
          ),
        )
        .then((_) {
          if (mounted) setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.miniGamesScreenTitle)),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final record = _controller.record;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.spaceLG),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 540),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header Section
                      const Text(
                        AppStrings.miniGamesScreenTitle,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spaceXS),
                      const Text(
                        AppStrings.miniGamesSubtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spaceXL),

                      // Game 1: Christmas Memory Match
                      MiniGameHubCard(
                        key: const Key('hub_card_memory_match'),
                        icon: Icons.grid_view_rounded,
                        title: AppStrings.memoryMatchTitle,
                        description: AppStrings.memoryMatchDesc,
                        statsHighlights: [
                          '${AppStrings.completedCountLabel}: ${record.memoryMatchCompletions}',
                          if (record.memoryMatchBestMoves != null)
                            '${AppStrings.bestMovesLabel}: ${record.memoryMatchBestMoves} lượt',
                        ],
                        playButtonKey: const Key('btn_play_memory_match'),
                        onPlay: () => _navigateToMemoryMatch(context),
                      ),
                      const SizedBox(height: AppDimensions.spaceLG),

                      // Game 2: Catch the Gifts
                      MiniGameHubCard(
                        key: const Key('hub_card_catch_gifts'),
                        icon: Icons.card_giftcard_rounded,
                        title: AppStrings.catchGiftsTitle,
                        description: AppStrings.catchGiftsDesc,
                        statsHighlights: [
                          '${AppStrings.highScoreLabel}: ${record.catchGiftsHighScore} điểm',
                          '${AppStrings.totalGiftsLabel}: ${record.catchGiftsTotalGifts}',
                          '${AppStrings.completedCountLabel}: ${record.catchGiftsCompletions}',
                        ],
                        playButtonKey: const Key('btn_play_catch_gifts'),
                        onPlay: () => _navigateToCatchGifts(context),
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
