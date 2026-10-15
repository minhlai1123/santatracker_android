import 'memory_card.dart';

class MemoryMatchState {
  final List<MemoryCard> cards;
  final List<int> flippedCardIndices;
  final int moves;
  final int matchedPairCount;
  final bool isCompleted;
  final bool isBusyWaiting;

  const MemoryMatchState({
    required this.cards,
    this.flippedCardIndices = const [],
    this.moves = 0,
    this.matchedPairCount = 0,
    this.isCompleted = false,
    this.isBusyWaiting = false,
  });

  int get totalPairs => cards.length ~/ 2;

  double get progressPercentage =>
      totalPairs > 0 ? (matchedPairCount / totalPairs).clamp(0.0, 1.0) : 0.0;

  MemoryMatchState copyWith({
    List<MemoryCard>? cards,
    List<int>? flippedCardIndices,
    int? moves,
    int? matchedPairCount,
    bool? isCompleted,
    bool? isBusyWaiting,
  }) {
    return MemoryMatchState(
      cards: cards ?? this.cards,
      flippedCardIndices: flippedCardIndices ?? this.flippedCardIndices,
      moves: moves ?? this.moves,
      matchedPairCount: matchedPairCount ?? this.matchedPairCount,
      isCompleted: isCompleted ?? this.isCompleted,
      isBusyWaiting: isBusyWaiting ?? this.isBusyWaiting,
    );
  }

  @override
  String toString() =>
      'MemoryMatchState(cards: ${cards.length}, moves: $moves, '
      'matched: $matchedPairCount/$totalPairs, completed: $isCompleted, busy: $isBusyWaiting)';
}
