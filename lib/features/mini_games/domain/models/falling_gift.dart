class FallingGift {
  final int id;
  final double normalizedX;
  final double normalizedY;
  final int points;
  final bool isCaught;
  final int colorSeed;

  const FallingGift({
    required this.id,
    required this.normalizedX,
    required this.normalizedY,
    this.points = 1,
    this.isCaught = false,
    this.colorSeed = 0,
  });

  FallingGift copyWith({
    int? id,
    double? normalizedX,
    double? normalizedY,
    int? points,
    bool? isCaught,
    int? colorSeed,
  }) {
    return FallingGift(
      id: id ?? this.id,
      normalizedX: normalizedX ?? this.normalizedX,
      normalizedY: normalizedY ?? this.normalizedY,
      points: points ?? this.points,
      isCaught: isCaught ?? this.isCaught,
      colorSeed: colorSeed ?? this.colorSeed,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FallingGift &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          normalizedX == other.normalizedX &&
          normalizedY == other.normalizedY &&
          points == other.points &&
          isCaught == other.isCaught &&
          colorSeed == other.colorSeed;

  @override
  int get hashCode =>
      id.hashCode ^
      normalizedX.hashCode ^
      normalizedY.hashCode ^
      points.hashCode ^
      isCaught.hashCode ^
      colorSeed.hashCode;

  @override
  String toString() =>
      'FallingGift(id: $id, pos: ($normalizedX, $normalizedY), points: $points, caught: $isCaught)';
}
