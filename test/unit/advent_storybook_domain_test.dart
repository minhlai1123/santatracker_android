import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/features/advent_storybook/data/memory_advent_storage.dart';
import 'package:chrimastsatastracker/features/advent_storybook/domain/models/advent_chapter_status.dart';
import 'package:chrimastsatastracker/features/advent_storybook/domain/services/advent_storybook_data.dart';
import 'package:chrimastsatastracker/features/advent_storybook/domain/services/advent_unlock_rules.dart';
import 'package:chrimastsatastracker/features/advent_storybook/presentation/controllers/advent_storybook_controller.dart';
import 'package:chrimastsatastracker/features/mini_games/data/memory_mini_games_storage.dart';
import 'package:chrimastsatastracker/features/mini_games/domain/models/mini_game_record.dart';
import 'package:chrimastsatastracker/features/mini_games/presentation/controllers/mini_games_controller.dart';

void main() {
  group('AdventStorybookData Content Tests', () {
    test(
      '1. Contains exactly 24 chapters with sequential 1..24 day numbers',
      () {
        final chapters = AdventStorybookData.allChapters;
        expect(chapters.length, equals(24));

        for (int i = 0; i < 24; i++) {
          final expectedDay = i + 1;
          expect(chapters[i].dayNumber, equals(expectedDay));
          expect(chapters[i].id, equals('chapter_$expectedDay'));
        }
      },
    );

    test('2. All chapters have distinct IDs and titles', () {
      final chapters = AdventStorybookData.allChapters;
      final ids = chapters.map((c) => c.id).toSet();
      final titles = chapters.map((c) => c.title).toSet();

      expect(ids.length, equals(24));
      expect(titles.length, equals(24));
    });

    test('3. Every chapter has rich and non-empty story, message, and riddle/activity', () {
      for (final chapter in AdventStorybookData.allChapters) {
        expect(chapter.title.trim(), isNotEmpty);
        expect(chapter.unlockRuleDescription.trim(), isNotEmpty);
        expect(chapter.storyContent.trim().length, greaterThan(30));
        expect(chapter.festiveMessage.trim(), isNotEmpty);
        expect(chapter.activityOrRiddle.trim(), isNotEmpty);
      }
    });

    test('4. No two chapters share duplicate story content', () {
      final stories = AdventStorybookData.allChapters
          .map((c) => c.storyContent)
          .toSet();
      expect(stories.length, equals(24));
    });
  });

  group('AdventUnlockRules Unit Tests', () {
    test('1. Chapter 1 is unlocked initially with default zero stats', () {
      final unlocked = AdventUnlockRules.evaluateAllUnlocked(
        record: const MiniGameRecord.initial(),
        existingUnlocked: const {1},
        readDays: const {},
      );

      expect(unlocked.contains(1), isTrue);
      expect(unlocked.contains(2), isFalse);
    });

    test('2. Completing Memory Match once unlocks Chapter 2', () {
      const record = MiniGameRecord(memoryMatchCompletions: 1);
      final unlocked = AdventUnlockRules.evaluateAllUnlocked(
        record: record,
        existingUnlocked: const {1},
        readDays: const {},
      );

      expect(unlocked.contains(2), isTrue);
      expect(unlocked.contains(3), isFalse);
    });

    test('3. Completing Catch the Gifts once unlocks Chapter 3', () {
      const record = MiniGameRecord(catchGiftsCompletions: 1);
      final unlocked = AdventUnlockRules.evaluateAllUnlocked(
        record: record,
        existingUnlocked: const {1},
        readDays: const {},
      );

      expect(unlocked.contains(3), isTrue);
    });

    test('4. Reading Chapter 1 unlocks Chapter 4', () {
      final unlocked = AdventUnlockRules.evaluateAllUnlocked(
        record: const MiniGameRecord.initial(),
        existingUnlocked: const {1},
        readDays: const {1},
      );

      expect(unlocked.contains(4), isTrue);
    });

    test('5. Catch the Gifts high score >= 10 unlocks Chapter 5', () {
      const record = MiniGameRecord(catchGiftsHighScore: 12);
      final unlocked = AdventUnlockRules.evaluateAllUnlocked(
        record: record,
        existingUnlocked: const {1},
        readDays: const {},
      );

      expect(unlocked.contains(5), isTrue);
    });

    test('6. Memory Match moves <= 18 unlocks Chapter 6', () {
      const record = MiniGameRecord(memoryMatchBestMoves: 14);
      final unlocked = AdventUnlockRules.evaluateAllUnlocked(
        record: record,
        existingUnlocked: const {1},
        readDays: const {},
      );

      expect(unlocked.contains(6), isTrue);
    });

    test('7. Monotonic unlock: existing unlocked days are never re-locked', () {
      final unlocked = AdventUnlockRules.evaluateAllUnlocked(
        record: const MiniGameRecord.initial(), // zero stats
        existingUnlocked: const {1, 2, 5, 10},
        readDays: const {},
      );

      expect(unlocked.contains(1), isTrue);
      expect(unlocked.contains(2), isTrue);
      expect(unlocked.contains(5), isTrue);
      expect(unlocked.contains(10), isTrue);
    });

    test('8. Full game progression can unlock all 24 chapters', () {
      // Simulate player who played both games and read chapters
      const masterRecord = MiniGameRecord(
        memoryMatchCompletions: 6,
        memoryMatchBestMoves: 10,
        catchGiftsCompletions: 5,
        catchGiftsHighScore: 45,
        catchGiftsTotalGifts: 85,
      );

      final readAll23 = {for (int i = 1; i <= 23; i++) i};

      final unlocked = AdventUnlockRules.evaluateAllUnlocked(
        record: masterRecord,
        existingUnlocked: const {1},
        readDays: readAll23,
      );

      expect(unlocked.length, equals(24));
      for (int i = 1; i <= 24; i++) {
        expect(unlocked.contains(i), isTrue);
      }
    });
  });

  group('AdventStorybookController Unit Tests', () {
    late MemoryAdventStorage storage;
    late MemoryMiniGamesStorage gamesStorage;
    late MiniGamesController gamesController;
    late AdventStorybookController controller;

    setUp(() async {
      storage = MemoryAdventStorage();
      gamesStorage = MemoryMiniGamesStorage();
      gamesController = MiniGamesController(storage: gamesStorage);
      await gamesController.initialize();

      controller = AdventStorybookController(
        storage: storage,
        gamesController: gamesController,
      );
      await controller.initialize();
    });

    test('1. Initial controller has Chapter 1 unlocked and 0 read', () {
      expect(controller.state.unlockedCount, equals(1));
      expect(controller.state.readCount, equals(0));
      expect(
        controller.state.getChapterStatus(1),
        equals(AdventChapterStatus.unlocked),
      );
      expect(
        controller.state.getChapterStatus(2),
        equals(AdventChapterStatus.locked),
      );
    });

    test(
      '2. Reading Chapter 1 marks it as read and unlocks Chapter 4',
      () async {
        await controller.markChapterAsRead(1);

        expect(controller.state.readCount, equals(1));
        expect(
          controller.state.getChapterStatus(1),
          equals(AdventChapterStatus.read),
        );
        // Reading Chapter 1 automatically satisfies Chapter 4 unlock condition
        expect(controller.state.isChapterUnlocked(4), isTrue);
      },
    );

    test('3. Cannot mark a locked chapter as read', () async {
      await controller.markChapterAsRead(2); // Chapter 2 is locked

      expect(controller.state.readCount, equals(0));
      expect(controller.state.isChapterRead(2), isFalse);
    });

    test(
      '4. Marking already read chapter is idempotent and does not double count',
      () async {
        await controller.markChapterAsRead(1);
        expect(controller.state.readCount, equals(1));

        await controller.markChapterAsRead(1);
        expect(controller.state.readCount, equals(1));
      },
    );

    test(
      '5. Syncing with mini game progress unlocks corresponding chapters',
      () async {
        await gamesController.recordMemoryMatchWin(14);
        await controller.syncWithMiniGames(gamesController.record);

        expect(controller.state.isChapterUnlocked(2), isTrue);
        expect(controller.state.isChapterUnlocked(6), isTrue);
      },
    );
  });
}
