import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chrimastsatastracker/features/advent_storybook/data/shared_preferences_advent_storage.dart';
import 'package:chrimastsatastracker/features/advent_storybook/presentation/controllers/advent_storybook_controller.dart';
import 'package:chrimastsatastracker/features/mini_games/data/memory_mini_games_storage.dart';
import 'package:chrimastsatastracker/features/mini_games/data/shared_preferences_mini_games_storage.dart';
import 'package:chrimastsatastracker/features/mini_games/presentation/controllers/mini_games_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SharedPreferencesAdventStorage Persistence Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('1. Saves and loads unlocked days and read days cleanly', () async {
      const storage = SharedPreferencesAdventStorage();

      await storage.saveUnlockedDays({1, 2, 3});
      await storage.saveReadDays({1, 2});

      final unlocked = await storage.loadUnlockedDays();
      final read = await storage.loadReadDays();

      expect(unlocked, equals({1, 2, 3}));
      expect(read, equals({1, 2}));
    });

    test('2. Filters out invalid, out-of-range, and corrupt strings', () async {
      SharedPreferences.setMockInitialValues({
        'advent_unlocked_days': ['1', '99', 'abc', '-5', '24'],
        'advent_read_days': ['0', '1', 'xyz', '25'],
      });

      const storage = SharedPreferencesAdventStorage();
      final unlocked = await storage.loadUnlockedDays();
      final read = await storage.loadReadDays();

      // Should keep 1 and 24, dropping 99, abc, -5
      expect(unlocked.contains(1), isTrue);
      expect(unlocked.contains(24), isTrue);
      expect(unlocked.contains(99), isFalse);
      expect(unlocked.contains(-5), isFalse);

      // Should keep 1, dropping 0, xyz, 25
      expect(read.contains(1), isTrue);
      expect(read.contains(0), isFalse);
      expect(read.contains(25), isFalse);
    });

    test('3. Reconstructing AdventStorybookController restores progress across app restart', () async {
      const adventStorage = SharedPreferencesAdventStorage();
      final gamesStorage = MemoryMiniGamesStorage();
      final gamesController = MiniGamesController(storage: gamesStorage);
      await gamesController.initialize();

      // Session 1: open and read Chapter 1
      final controller1 = AdventStorybookController(
        storage: adventStorage,
        gamesController: gamesController,
      );
      await controller1.initialize();
      await controller1.markChapterAsRead(1);

      expect(controller1.state.readCount, equals(1));
      expect(controller1.state.isChapterRead(1), isTrue);

      // Session 2: simulate app restart with brand new controller
      final controller2 = AdventStorybookController(
        storage: adventStorage,
        gamesController: gamesController,
      );
      await controller2.initialize();

      expect(controller2.state.isChapterRead(1), isTrue);
      expect(controller2.state.readCount, equals(1));
      expect(
        controller2.state.isChapterUnlocked(4),
        isTrue,
      ); // Chapter 4 was unlocked by reading Chapter 1!
    });

    test('4. Cross-feature persistence: SharedPreferences across MiniGames and Advent Storybook', () async {
      const gamesStorage = SharedPreferencesMiniGamesStorage();
      const adventStorage = SharedPreferencesAdventStorage();

      // 1. First session: Play games and earn milestones
      final gamesController1 = MiniGamesController(storage: gamesStorage);
      await gamesController1.initialize();
      await gamesController1.recordMemoryMatchWin(14);
      await gamesController1.recordCatchGiftsGameOver(
        score: 45,
        giftsCaught: 25,
      );

      // Open Advent Storybook in session 1
      final adventController1 = AdventStorybookController(
        storage: adventStorage,
        gamesController: gamesController1,
      );
      await adventController1.initialize();

      // Verify milestones unlocked
      expect(adventController1.state.isChapterUnlocked(1), isTrue); // default
      expect(
        adventController1.state.isChapterUnlocked(2),
        isTrue,
      ); // Memory win >= 1
      expect(
        adventController1.state.isChapterUnlocked(3),
        isTrue,
      ); // Catch completions >= 1
      expect(
        adventController1.state.isChapterUnlocked(5),
        isTrue,
      ); // High score >= 10
      expect(
        adventController1.state.isChapterUnlocked(6),
        isTrue,
      ); // Best moves <= 18 (14)
      expect(
        adventController1.state.isChapterUnlocked(7),
        isTrue,
      ); // Total gifts >= 15 (25)
      expect(
        adventController1.state.isChapterUnlocked(10),
        isTrue,
      ); // High score >= 20 (45)

      // Read Chapter 1
      await adventController1.markChapterAsRead(1);
      expect(adventController1.state.isChapterRead(1), isTrue);
      expect(
        adventController1.state.isChapterUnlocked(4),
        isTrue,
      ); // unlocked by reading Ch 1

      // 2. Simulate complete app restart: dispose and create fresh controllers
      adventController1.dispose();
      gamesController1.dispose();

      final gamesController2 = MiniGamesController(storage: gamesStorage);
      await gamesController2.initialize();

      final adventController2 = AdventStorybookController(
        storage: adventStorage,
        gamesController: gamesController2,
      );
      await adventController2.initialize();

      // Verify complete restoration across both domains
      expect(gamesController2.record.memoryMatchCompletions, equals(1));
      expect(gamesController2.record.memoryMatchBestMoves, equals(14));
      expect(gamesController2.record.catchGiftsHighScore, equals(45));
      expect(gamesController2.record.catchGiftsTotalGifts, equals(25));

      expect(adventController2.state.isChapterRead(1), isTrue);
      expect(adventController2.state.isChapterUnlocked(4), isTrue);
      expect(adventController2.state.isChapterUnlocked(10), isTrue);
    });
  });
}
