import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/features/mini_games/data/memory_mini_games_storage.dart';
import 'package:chrimastsatastracker/features/mini_games/domain/services/catch_gifts_engine.dart';
import 'package:chrimastsatastracker/features/mini_games/domain/services/memory_match_engine.dart';
import 'package:chrimastsatastracker/features/mini_games/presentation/controllers/mini_games_controller.dart';

void main() {
  group('MemoryMatchEngine Unit Tests', () {
    test('1. Initial deck contains exactly 12 cards and 6 distinct pairs', () {
      final deck = MemoryMatchEngine.createInitialDeck(random: Random(42));
      expect(deck.length, equals(12));

      final pairCounts = <int, int>{};
      for (final card in deck) {
        pairCounts[card.pairId] = (pairCounts[card.pairId] ?? 0) + 1;
        expect(card.isFlipped, isFalse);
        expect(card.isMatched, isFalse);
        expect(card.name, isNotEmpty);
      }

      expect(pairCounts.length, equals(6));
      for (final count in pairCounts.values) {
        expect(count, equals(2));
      }
    });

    test('2. Flipping a valid card marks it as flipped and updates state', () {
      final state = MemoryMatchEngine.createInitialState(random: Random(42));
      final nextState = MemoryMatchEngine.flipCard(state, 0);

      expect(nextState.cards[0].isFlipped, isTrue);
      expect(nextState.flippedCardIndices, equals([0]));
      expect(nextState.moves, equals(0));
      expect(nextState.matchedPairCount, equals(0));
      expect(nextState.isBusyWaiting, isFalse);
    });

    test('3. Cannot flip an already flipped card or invalid index', () {
      final state = MemoryMatchEngine.createInitialState(random: Random(42));
      final flippedState = MemoryMatchEngine.flipCard(state, 0);

      // Attempt to flip same card again
      final doubleFlip = MemoryMatchEngine.flipCard(flippedState, 0);
      expect(doubleFlip, equals(flippedState));

      // Attempt out-of-bounds flip
      final outOfBounds1 = MemoryMatchEngine.flipCard(state, -1);
      final outOfBounds2 = MemoryMatchEngine.flipCard(state, 99);
      expect(outOfBounds1, equals(state));
      expect(outOfBounds2, equals(state));
    });

    test(
      '4. Matching pair marks both as matched and increments pairs count',
      () {
        final state = MemoryMatchEngine.createInitialState(random: Random(42));
        final firstIndex = 0;
        final targetPairId = state.cards[firstIndex].pairId;
        final secondIndex = state.cards.indexWhere(
          (c) => c.pairId == targetPairId && c.id != firstIndex,
        );

        expect(secondIndex, isNot(equals(-1)));

        final state1 = MemoryMatchEngine.flipCard(state, firstIndex);
        final state2 = MemoryMatchEngine.flipCard(state1, secondIndex);

        expect(state2.cards[firstIndex].isMatched, isTrue);
        expect(state2.cards[secondIndex].isMatched, isTrue);
        expect(state2.matchedPairCount, equals(1));
        expect(state2.moves, equals(1));
        expect(state2.flippedCardIndices, isEmpty);
        expect(state2.isBusyWaiting, isFalse);
      },
    );

    test('5. Non-matching pair enters busy waiting and resolves correctly', () {
      final state = MemoryMatchEngine.createInitialState(random: Random(42));
      final firstIndex = 0;
      final firstPairId = state.cards[firstIndex].pairId;
      final secondIndex = state.cards.indexWhere(
        (c) => c.pairId != firstPairId,
      );

      final state1 = MemoryMatchEngine.flipCard(state, firstIndex);
      final state2 = MemoryMatchEngine.flipCard(state1, secondIndex);

      expect(state2.moves, equals(1));
      expect(state2.matchedPairCount, equals(0));
      expect(state2.flippedCardIndices, equals([firstIndex, secondIndex]));
      expect(state2.isBusyWaiting, isTrue);

      // While busy waiting, further flips must be blocked
      final blockedFlip = MemoryMatchEngine.flipCard(state2, 2);
      expect(blockedFlip, equals(state2));

      // Resolve mismatch flips them back
      final resolved = MemoryMatchEngine.resolveMismatch(state2);
      expect(resolved.cards[firstIndex].isFlipped, isFalse);
      expect(resolved.cards[secondIndex].isFlipped, isFalse);
      expect(resolved.flippedCardIndices, isEmpty);
      expect(resolved.isBusyWaiting, isFalse);
    });

    test('6. Matching all 6 pairs achieves victory and 100% progress', () {
      var state = MemoryMatchEngine.createInitialState(random: Random(42));

      for (int pairId = 0; pairId < 6; pairId++) {
        final pairIndices = <int>[];
        for (int i = 0; i < state.cards.length; i++) {
          if (state.cards[i].pairId == pairId) {
            pairIndices.add(i);
          }
        }
        expect(pairIndices.length, equals(2));

        state = MemoryMatchEngine.flipCard(state, pairIndices[0]);
        state = MemoryMatchEngine.flipCard(state, pairIndices[1]);
      }

      expect(state.matchedPairCount, equals(6));
      expect(state.isCompleted, isTrue);
      expect(state.progressPercentage, equals(1.0));
      expect(state.moves, equals(6));

      // Flips after victory are ignored
      final postWin = MemoryMatchEngine.flipCard(state, 0);
      expect(postWin, equals(state));
    });
  });

  group('CatchGiftsEngine Unit Tests', () {
    test('1. Initial session starts with 30s, score 0, and active targets', () {
      final state = CatchGiftsEngine.startSession(
        durationSeconds: 30,
        random: Random(42),
      );

      expect(state.score, equals(0));
      expect(state.remainingSeconds, equals(30));
      expect(state.isPlaying, isTrue);
      expect(state.isGameOver, isFalse);
      expect(state.activeGifts, isNotEmpty);
      expect(state.totalGiftsCaught, equals(0));

      for (final gift in state.activeGifts) {
        expect(gift.normalizedX, inInclusiveRange(0.1, 0.9));
        expect(gift.normalizedY, inInclusiveRange(0.1, 0.85));
        expect(gift.points, greaterThanOrEqualTo(1));
      }
    });

    test('2. Tapping valid target increments score and total gifts caught', () {
      var state = CatchGiftsEngine.startSession(random: Random(42));
      final target = state.activeGifts.first;

      state = CatchGiftsEngine.tapTarget(state, target.id);

      expect(state.score, equals(target.points));
      expect(state.totalGiftsCaught, equals(1));
      expect(state.activeGifts.any((g) => g.id == target.id), isFalse);
    });

    test('3. Tapping empty area does not increment score', () {
      final state = CatchGiftsEngine.startSession(random: Random(42));
      final afterEmptyTap = CatchGiftsEngine.tapEmptyArea(state);

      expect(afterEmptyTap.score, equals(state.score));
      expect(afterEmptyTap.totalGiftsCaught, equals(state.totalGiftsCaught));
    });

    test(
      '4. Ticking countdown decrements time and triggers game over at 0s',
      () {
        var state = CatchGiftsEngine.startSession(
          durationSeconds: 2,
          random: Random(42),
        );
        expect(state.remainingSeconds, equals(2));

        state = CatchGiftsEngine.tickSecond(state, random: Random(42));
        expect(state.remainingSeconds, equals(1));
        expect(state.isPlaying, isTrue);
        expect(state.isGameOver, isFalse);

        state = CatchGiftsEngine.tickSecond(state, random: Random(42));
        expect(state.remainingSeconds, equals(0));
        expect(state.isPlaying, isFalse);
        expect(state.isGameOver, isTrue);
        expect(state.activeGifts, isEmpty);

        // Ticks after game over are idempotent
        final postGameOver = CatchGiftsEngine.tickSecond(
          state,
          random: Random(42),
        );
        expect(postGameOver, equals(state));
      },
    );

    test('5. Tapping target after game over does not score points', () {
      var state = CatchGiftsEngine.startSession(
        durationSeconds: 1,
        random: Random(42),
      );
      final targetId = state.activeGifts.first.id;

      state = CatchGiftsEngine.tickSecond(
        state,
        random: Random(42),
      ); // Game Over
      expect(state.isGameOver, isTrue);

      final tapAttempt = CatchGiftsEngine.tapTarget(state, targetId);
      expect(tapAttempt.score, equals(0));
      expect(tapAttempt.totalGiftsCaught, equals(0));
    });
  });

  group('MiniGamesController Unit Tests', () {
    late MemoryMiniGamesStorage storage;
    late MiniGamesController controller;

    setUp(() async {
      storage = MemoryMiniGamesStorage();
      controller = MiniGamesController(storage: storage);
      await controller.initialize();
    });

    test('1. Initial record starts with 0 completions and 0 high score', () {
      expect(controller.record.memoryMatchCompletions, equals(0));
      expect(controller.record.memoryMatchBestMoves, isNull);
      expect(controller.record.catchGiftsCompletions, equals(0));
      expect(controller.record.catchGiftsHighScore, equals(0));
      expect(controller.record.catchGiftsTotalGifts, equals(0));
    });

    test(
      '2. Recording Memory Match win tracks completions and best moves',
      () async {
        await controller.recordMemoryMatchWin(16);
        expect(controller.record.memoryMatchCompletions, equals(1));
        expect(controller.record.memoryMatchBestMoves, equals(16));

        // Higher moves should not overwrite best moves
        await controller.recordMemoryMatchWin(20);
        expect(controller.record.memoryMatchCompletions, equals(2));
        expect(controller.record.memoryMatchBestMoves, equals(16));

        // Lower moves should update best moves
        await controller.recordMemoryMatchWin(12);
        expect(controller.record.memoryMatchCompletions, equals(3));
        expect(controller.record.memoryMatchBestMoves, equals(12));
      },
    );

    test(
      '3. Recording Catch the Gifts game over tracks high score and gifts',
      () async {
        await controller.recordCatchGiftsGameOver(score: 25, giftsCaught: 18);
        expect(controller.record.catchGiftsCompletions, equals(1));
        expect(controller.record.catchGiftsHighScore, equals(25));
        expect(controller.record.catchGiftsTotalGifts, equals(18));

        // Lower score should not overwrite high score, but gifts accumulate
        await controller.recordCatchGiftsGameOver(score: 15, giftsCaught: 10);
        expect(controller.record.catchGiftsCompletions, equals(2));
        expect(controller.record.catchGiftsHighScore, equals(25));
        expect(controller.record.catchGiftsTotalGifts, equals(28));
      },
    );
  });
}
