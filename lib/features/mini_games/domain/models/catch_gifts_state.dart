import 'falling_gift.dart';

class CatchGiftsState {
  final int score;
  final int remainingSeconds;
  final int totalDurationSeconds;
  final bool isPlaying;
  final bool isGameOver;
  final List<FallingGift> activeGifts;
  final int totalGiftsCaught;
  final int nextGiftId;

  const CatchGiftsState({
    this.score = 0,
    this.remainingSeconds = 30,
    this.totalDurationSeconds = 30,
    this.isPlaying = false,
    this.isGameOver = false,
    this.activeGifts = const [],
    this.totalGiftsCaught = 0,
    this.nextGiftId = 1,
  });

  const CatchGiftsState.initial({int durationSeconds = 30})
    : score = 0,
      remainingSeconds = durationSeconds,
      totalDurationSeconds = durationSeconds,
      isPlaying = false,
      isGameOver = false,
      activeGifts = const [],
      totalGiftsCaught = 0,
      nextGiftId = 1;

  double get timeProgress => totalDurationSeconds > 0
      ? (remainingSeconds / totalDurationSeconds).clamp(0.0, 1.0)
      : 0.0;

  CatchGiftsState copyWith({
    int? score,
    int? remainingSeconds,
    int? totalDurationSeconds,
    bool? isPlaying,
    bool? isGameOver,
    List<FallingGift>? activeGifts,
    int? totalGiftsCaught,
    int? nextGiftId,
  }) {
    return CatchGiftsState(
      score: score ?? this.score,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      totalDurationSeconds: totalDurationSeconds ?? this.totalDurationSeconds,
      isPlaying: isPlaying ?? this.isPlaying,
      isGameOver: isGameOver ?? this.isGameOver,
      activeGifts: activeGifts ?? this.activeGifts,
      totalGiftsCaught: totalGiftsCaught ?? this.totalGiftsCaught,
      nextGiftId: nextGiftId ?? this.nextGiftId,
    );
  }

  @override
  String toString() =>
      'CatchGiftsState(score: $score, remaining: ${remainingSeconds}s, '
      'playing: $isPlaying, gameOver: $isGameOver, gifts: ${activeGifts.length}, caught: $totalGiftsCaught)';
}
