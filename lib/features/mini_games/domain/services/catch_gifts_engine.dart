import 'dart:math';

import '../models/catch_gifts_state.dart';
import '../models/falling_gift.dart';

class CatchGiftsEngine {
  static const int defaultDurationSeconds = 30;
  static const int maxSimultaneousGifts = 4;

  static CatchGiftsState startSession({
    int durationSeconds = defaultDurationSeconds,
    Random? random,
  }) {
    final rng = random ?? Random();
    var state = CatchGiftsState(
      score: 0,
      remainingSeconds: durationSeconds,
      totalDurationSeconds: durationSeconds,
      isPlaying: true,
      isGameOver: false,
      activeGifts: const [],
      totalGiftsCaught: 0,
      nextGiftId: 1,
    );

    // Spawn 2 initial gifts
    state = spawnGift(state, random: rng);
    state = spawnGift(state, random: rng);
    return state;
  }

  static CatchGiftsState spawnGift(
    CatchGiftsState state, {
    Random? random,
    double? forceX,
    double? forceY,
    int? forcePoints,
  }) {
    if (!state.isPlaying || state.isGameOver) {
      return state;
    }

    final rng = random ?? Random();
    final double x = forceX ?? (0.12 + (rng.nextDouble() * 0.74));
    final double y = forceY ?? (0.15 + (rng.nextDouble() * 0.65));
    final int points = forcePoints ?? 1;
    final int colorSeed = rng.nextInt(4);

    final newGift = FallingGift(
      id: state.nextGiftId,
      normalizedX: x.clamp(0.1, 0.9),
      normalizedY: y.clamp(0.1, 0.85),
      points: points,
      colorSeed: colorSeed,
    );

    final currentGifts = List<FallingGift>.from(state.activeGifts);
    if (currentGifts.length >= maxSimultaneousGifts) {
      currentGifts.removeAt(0); // remove oldest
    }
    currentGifts.add(newGift);

    return state.copyWith(
      activeGifts: currentGifts,
      nextGiftId: state.nextGiftId + 1,
    );
  }

  static CatchGiftsState tapTarget(CatchGiftsState state, int giftId) {
    if (!state.isPlaying || state.isGameOver) {
      return state;
    }

    final giftIndex = state.activeGifts.indexWhere((g) => g.id == giftId);
    if (giftIndex == -1) {
      return state;
    }

    final gift = state.activeGifts[giftIndex];
    if (gift.isCaught) {
      return state;
    }

    final updatedGifts = List<FallingGift>.from(state.activeGifts);
    updatedGifts.removeAt(giftIndex);

    final nextScore = state.score + gift.points;
    final nextTotalCaught = state.totalGiftsCaught + 1;

    return state.copyWith(
      score: nextScore,
      totalGiftsCaught: nextTotalCaught,
      activeGifts: updatedGifts,
    );
  }

  static CatchGiftsState tapEmptyArea(CatchGiftsState state) {
    // Tapping empty area does not increase score
    return state;
  }

  static CatchGiftsState tickSecond(CatchGiftsState state, {Random? random}) {
    if (!state.isPlaying || state.isGameOver) {
      return state;
    }

    final nextSeconds = state.remainingSeconds - 1;
    if (nextSeconds <= 0) {
      // Game over triggered exactly once
      return state.copyWith(
        remainingSeconds: 0,
        isPlaying: false,
        isGameOver: true,
        activeGifts: const [],
      );
    }

    var nextState = state.copyWith(remainingSeconds: nextSeconds);

    // Keep at least 2 gifts on screen
    final rng = random ?? Random();
    if (nextState.activeGifts.length < 2) {
      nextState = spawnGift(nextState, random: rng);
    } else if (nextState.activeGifts.length < maxSimultaneousGifts &&
        rng.nextDouble() > 0.4) {
      nextState = spawnGift(nextState, random: rng);
    }

    return nextState;
  }
}
