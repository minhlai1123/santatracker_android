import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/core/constants/app_strings.dart';
import 'package:chrimastsatastracker/core/theme/app_theme.dart';
import 'package:chrimastsatastracker/features/mini_games/data/memory_mini_games_storage.dart';
import 'package:chrimastsatastracker/features/mini_games/domain/models/mini_game_record.dart';
import 'package:chrimastsatastracker/features/mini_games/presentation/controllers/catch_gifts_controller.dart';
import 'package:chrimastsatastracker/features/mini_games/presentation/controllers/memory_match_controller.dart';
import 'package:chrimastsatastracker/features/mini_games/presentation/controllers/mini_games_controller.dart';
import 'package:chrimastsatastracker/features/mini_games/presentation/screens/catch_gifts_screen.dart';
import 'package:chrimastsatastracker/features/mini_games/presentation/screens/christmas_mini_games_screen.dart';
import 'package:chrimastsatastracker/features/mini_games/presentation/screens/memory_match_screen.dart';

void main() {
  Widget buildTestableHub({MiniGamesController? controller}) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: ChristmasMiniGamesScreen(controller: controller),
    );
  }

  group('ChristmasMiniGamesScreen Widget & Responsive Tests', () {
    testWidgets(
      '1. Renders screen title, subtitle, and both mini game hub cards',
      (WidgetTester tester) async {
        final storage = MemoryMiniGamesStorage(
          initialRecord: const MiniGameRecord(
            memoryMatchCompletions: 2,
            memoryMatchBestMoves: 14,
            catchGiftsHighScore: 25,
            catchGiftsTotalGifts: 30,
          ),
        );
        final controller = MiniGamesController(storage: storage);
        await controller.initialize();

        await tester.pumpWidget(buildTestableHub(controller: controller));
        await tester.pumpAndSettle();

        expect(
          find.text(AppStrings.miniGamesScreenTitle),
          findsAtLeastNWidgets(1),
        );
        expect(find.text(AppStrings.miniGamesSubtitle), findsOneWidget);

        // Memory Match card & stats
        expect(find.byKey(const Key('hub_card_memory_match')), findsOneWidget);
        expect(find.text(AppStrings.memoryMatchTitle), findsOneWidget);
        expect(find.byKey(const Key('btn_play_memory_match')), findsOneWidget);
        expect(
          find.textContaining('${AppStrings.completedCountLabel}: 2'),
          findsOneWidget,
        );
        expect(find.textContaining('14 moves'), findsOneWidget);

        // Catch the Gifts card & stats
        expect(find.byKey(const Key('hub_card_catch_gifts')), findsOneWidget);
        expect(find.text(AppStrings.catchGiftsTitle), findsOneWidget);
        expect(find.byKey(const Key('btn_play_catch_gifts')), findsOneWidget);
        expect(
          find.textContaining('${AppStrings.highScoreLabel}: 25 pts'),
          findsOneWidget,
        );
        expect(
          find.textContaining('${AppStrings.totalGiftsLabel}: 30'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      '2. Tapping play Memory Match navigates to game and can match pairs',
      (WidgetTester tester) async {
        final storage = MemoryMiniGamesStorage();
        final statsController = MiniGamesController(storage: storage);
        await statsController.initialize();

        final gameController = MemoryMatchController(
          statsController: statsController,
          mismatchDelay: Duration.zero, // instant for testing
          random: Random(42),
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.lightTheme,
            home: MemoryMatchScreen(
              controller: gameController,
              statsController: statsController,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text(AppStrings.memoryMatchTitle), findsOneWidget);
        expect(find.text(AppStrings.movesLabel), findsOneWidget);
        expect(find.text('0 / 6'), findsOneWidget);

        // Flip first card (index 0)
        final card0 = find.byKey(const Key('memory_card_0'));
        await tester.ensureVisible(card0);
        await tester.tap(card0);
        await tester.pumpAndSettle();

        expect(gameController.state.cards[0].isFlipped, isTrue);

        // Find matching pair for card 0
        final targetPairId = gameController.state.cards[0].pairId;
        final matchIndex = gameController.state.cards.indexWhere(
          (c) => c.pairId == targetPairId && c.id != 0,
        );

        final secondCard = find.byKey(Key('memory_card_$matchIndex'));
        await tester.ensureVisible(secondCard);
        await tester.tap(secondCard);
        await tester.pumpAndSettle();

        expect(gameController.state.cards[0].isMatched, isTrue);
        expect(gameController.state.cards[matchIndex].isMatched, isTrue);
        expect(find.text('1 / 6'), findsOneWidget);

        // Reset button
        final resetBtn = find.byKey(const Key('btn_reset_memory_match'));
        await tester.ensureVisible(resetBtn);
        await tester.tap(resetBtn);
        await tester.pumpAndSettle();

        expect(find.text('0 / 6'), findsOneWidget);
      },
    );

    testWidgets(
      '3. Catch the Gifts can start, tap target to score, and game over on 0s',
      (WidgetTester tester) async {
        final storage = MemoryMiniGamesStorage();
        final statsController = MiniGamesController(storage: storage);
        await statsController.initialize();

        final gameController = CatchGiftsController(
          statsController: statsController,
          durationSeconds: 30,
          random: Random(42),
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.lightTheme,
            home: CatchGiftsScreen(
              controller: gameController,
              statsController: statsController,
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Intro view
        expect(find.text(AppStrings.catchGiftsInstructions), findsOneWidget);
        final startBtn = find.byKey(const Key('btn_start_catch_gifts'));
        expect(startBtn, findsOneWidget);

        // Tap start game
        await tester.tap(startBtn);
        await tester.pump();

        expect(gameController.state.isPlaying, isTrue);
        expect(gameController.state.activeGifts, isNotEmpty);

        // Tap first target
        final firstGiftId = gameController.state.activeGifts.first.id;
        final targetFinder = find.byKey(Key('gift_target_$firstGiftId'));
        expect(targetFinder, findsOneWidget);

        await tester.tap(targetFinder);
        await tester.pump();

        expect(gameController.state.score, greaterThanOrEqualTo(1));

        // Tick to 0 to simulate game over
        while (gameController.state.remainingSeconds > 0) {
          gameController.manualTick();
        }
        await tester.pumpAndSettle();

        expect(gameController.state.isGameOver, isTrue);
        expect(find.text(AppStrings.catchGiftsGameOverTitle), findsOneWidget);
        expect(find.byKey(const Key('btn_replay_catch_gifts')), findsOneWidget);
      },
    );

    testWidgets('4. Responsive check on small phone (360x640)', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestableHub());
      await tester.pumpAndSettle();

      expect(
        find.text(AppStrings.miniGamesScreenTitle),
        findsAtLeastNWidgets(1),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('5. Responsive check on standard phone (390x844)', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestableHub());
      await tester.pumpAndSettle();

      expect(
        find.text(AppStrings.miniGamesScreenTitle),
        findsAtLeastNWidgets(1),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('6. Responsive check on tablet screen (768x1024)', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(768, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestableHub());
      await tester.pumpAndSettle();

      expect(
        find.text(AppStrings.miniGamesScreenTitle),
        findsAtLeastNWidgets(1),
      );
      expect(tester.takeException(), isNull);
    });
  });
}
