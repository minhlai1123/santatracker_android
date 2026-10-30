class MiniGameRecord {
  final int memoryMatchCompletions;
  final int? memoryMatchBestMoves;
  final int catchGiftsCompletions;
  final int catchGiftsHighScore;
  final int catchGiftsTotalGifts;

  const MiniGameRecord({
    this.memoryMatchCompletions = 0,
    this.memoryMatchBestMoves,
    this.catchGiftsCompletions = 0,
    this.catchGiftsHighScore = 0,
    this.catchGiftsTotalGifts = 0,
  });

  const MiniGameRecord.initial()
    : memoryMatchCompletions = 0,
      memoryMatchBestMoves = null,
      catchGiftsCompletions = 0,
      catchGiftsHighScore = 0,
      catchGiftsTotalGifts = 0;

  MiniGameRecord copyWith({
    int? memoryMatchCompletions,
    int? Function()? memoryMatchBestMoves,
    int? catchGiftsCompletions,
    int? catchGiftsHighScore,
    int? catchGiftsTotalGifts,
  }) {
    return MiniGameRecord(
      memoryMatchCompletions:
          memoryMatchCompletions ?? this.memoryMatchCompletions,
      memoryMatchBestMoves: memoryMatchBestMoves != null
          ? memoryMatchBestMoves()
          : this.memoryMatchBestMoves,
      catchGiftsCompletions:
          catchGiftsCompletions ?? this.catchGiftsCompletions,
      catchGiftsHighScore: catchGiftsHighScore ?? this.catchGiftsHighScore,
      catchGiftsTotalGifts: catchGiftsTotalGifts ?? this.catchGiftsTotalGifts,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memoryMatchCompletions': memoryMatchCompletions,
      'memoryMatchBestMoves': memoryMatchBestMoves,
      'catchGiftsCompletions': catchGiftsCompletions,
      'catchGiftsHighScore': catchGiftsHighScore,
      'catchGiftsTotalGifts': catchGiftsTotalGifts,
    };
  }

  factory MiniGameRecord.fromJson(Map<String, dynamic> json) {
    return MiniGameRecord(
      memoryMatchCompletions:
          (json['memoryMatchCompletions'] as num?)?.toInt() ?? 0,
      memoryMatchBestMoves: (json['memoryMatchBestMoves'] as num?)?.toInt(),
      catchGiftsCompletions:
          (json['catchGiftsCompletions'] as num?)?.toInt() ?? 0,
      catchGiftsHighScore: (json['catchGiftsHighScore'] as num?)?.toInt() ?? 0,
      catchGiftsTotalGifts:
          (json['catchGiftsTotalGifts'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MiniGameRecord &&
          runtimeType == other.runtimeType &&
          memoryMatchCompletions == other.memoryMatchCompletions &&
          memoryMatchBestMoves == other.memoryMatchBestMoves &&
          catchGiftsCompletions == other.catchGiftsCompletions &&
          catchGiftsHighScore == other.catchGiftsHighScore &&
          catchGiftsTotalGifts == other.catchGiftsTotalGifts;

  @override
  int get hashCode =>
      memoryMatchCompletions.hashCode ^
      memoryMatchBestMoves.hashCode ^
      catchGiftsCompletions.hashCode ^
      catchGiftsHighScore.hashCode ^
      catchGiftsTotalGifts.hashCode;

  @override
  String toString() {
    return 'MiniGameRecord(memoryCompletions: $memoryMatchCompletions, '
        'bestMoves: $memoryMatchBestMoves, catchCompletions: $catchGiftsCompletions, '
        'highScore: $catchGiftsHighScore, totalGifts: $catchGiftsTotalGifts)';
  }
}
