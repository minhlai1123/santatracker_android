import 'package:flutter/material.dart';

class MemoryCard {
  final int id;
  final int pairId;
  final IconData icon;
  final String name;
  final bool isFlipped;
  final bool isMatched;

  const MemoryCard({
    required this.id,
    required this.pairId,
    required this.icon,
    required this.name,
    this.isFlipped = false,
    this.isMatched = false,
  });

  MemoryCard copyWith({
    int? id,
    int? pairId,
    IconData? icon,
    String? name,
    bool? isFlipped,
    bool? isMatched,
  }) {
    return MemoryCard(
      id: id ?? this.id,
      pairId: pairId ?? this.pairId,
      icon: icon ?? this.icon,
      name: name ?? this.name,
      isFlipped: isFlipped ?? this.isFlipped,
      isMatched: isMatched ?? this.isMatched,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemoryCard &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          pairId == other.pairId &&
          icon == other.icon &&
          name == other.name &&
          isFlipped == other.isFlipped &&
          isMatched == other.isMatched;

  @override
  int get hashCode =>
      id.hashCode ^
      pairId.hashCode ^
      icon.hashCode ^
      name.hashCode ^
      isFlipped.hashCode ^
      isMatched.hashCode;

  @override
  String toString() =>
      'MemoryCard(id: $id, pairId: $pairId, name: $name, flipped: $isFlipped, matched: $isMatched)';
}
