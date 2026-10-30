import 'dart:math';

import 'package:flutter/material.dart';

import '../models/memory_card.dart';
import '../models/memory_match_state.dart';

class MemoryMatchEngine {
  static const int totalPairsCount = 6;

  static const List<({IconData icon, String name})> cardDefinitions = [
    (icon: Icons.park_rounded, name: 'Christmas Tree'),
    (icon: Icons.card_giftcard_rounded, name: 'Gift Box'),
    (icon: Icons.pets_rounded, name: 'Reindeer'),
    (icon: Icons.ac_unit_rounded, name: 'Snowman'),
    (icon: Icons.star_rounded, name: 'Golden Star'),
    (icon: Icons.notifications_active_rounded, name: 'Jingle Bells'),
  ];

  static List<MemoryCard> createInitialDeck({Random? random}) {
    final List<MemoryCard> deck = [];

    for (int pairId = 0; pairId < cardDefinitions.length; pairId++) {
      final def = cardDefinitions[pairId];
      deck.add(
        MemoryCard(
          id: -1, // will be reassigned after shuffle
          pairId: pairId,
          icon: def.icon,
          name: def.name,
        ),
      );
      deck.add(
        MemoryCard(id: -1, pairId: pairId, icon: def.icon, name: def.name),
      );
    }

    if (random != null) {
      deck.shuffle(random);
    } else {
      deck.shuffle();
    }

    // Reassign stable linear indices 0..deck.length - 1
    return List.generate(
      deck.length,
      (index) => deck[index].copyWith(id: index),
      growable: false,
    );
  }

  static MemoryMatchState createInitialState({Random? random}) {
    return MemoryMatchState(
      cards: createInitialDeck(random: random),
      flippedCardIndices: const [],
      moves: 0,
      matchedPairCount: 0,
      isCompleted: false,
      isBusyWaiting: false,
    );
  }

  static MemoryMatchState flipCard(MemoryMatchState current, int cardIndex) {
    if (current.isBusyWaiting || current.isCompleted) {
      return current;
    }
    if (cardIndex < 0 || cardIndex >= current.cards.length) {
      return current;
    }

    final targetCard = current.cards[cardIndex];
    if (targetCard.isFlipped || targetCard.isMatched) {
      return current;
    }
    if (current.flippedCardIndices.contains(cardIndex)) {
      return current;
    }

    final updatedCards = List<MemoryCard>.from(current.cards);

    if (current.flippedCardIndices.isEmpty) {
      // First card flipped
      updatedCards[cardIndex] = targetCard.copyWith(isFlipped: true);
      return current.copyWith(
        cards: updatedCards,
        flippedCardIndices: [cardIndex],
      );
    }

    if (current.flippedCardIndices.length == 1) {
      // Second card flipped
      final firstIndex = current.flippedCardIndices.first;
      final firstCard = updatedCards[firstIndex];
      updatedCards[cardIndex] = targetCard.copyWith(isFlipped: true);

      final nextMoves = current.moves + 1;

      if (firstCard.pairId == targetCard.pairId) {
        // Matched!
        updatedCards[firstIndex] = firstCard.copyWith(
          isFlipped: true,
          isMatched: true,
        );
        updatedCards[cardIndex] = targetCard.copyWith(
          isFlipped: true,
          isMatched: true,
        );

        final nextMatched = current.matchedPairCount + 1;
        final isCompleted = nextMatched == current.totalPairs;

        return current.copyWith(
          cards: updatedCards,
          flippedCardIndices: const [],
          moves: nextMoves,
          matchedPairCount: nextMatched,
          isCompleted: isCompleted,
          isBusyWaiting: false,
        );
      } else {
        // Mismatch - enter busy waiting so player can view the pair
        return current.copyWith(
          cards: updatedCards,
          flippedCardIndices: [firstIndex, cardIndex],
          moves: nextMoves,
          isBusyWaiting: true,
        );
      }
    }

    return current;
  }

  static MemoryMatchState resolveMismatch(MemoryMatchState current) {
    if (!current.isBusyWaiting || current.flippedCardIndices.isEmpty) {
      return current;
    }

    final updatedCards = List<MemoryCard>.from(current.cards);
    for (final index in current.flippedCardIndices) {
      if (index >= 0 && index < updatedCards.length) {
        final card = updatedCards[index];
        if (!card.isMatched) {
          updatedCards[index] = card.copyWith(isFlipped: false);
        }
      }
    }

    return current.copyWith(
      cards: updatedCards,
      flippedCardIndices: const [],
      isBusyWaiting: false,
    );
  }
}
