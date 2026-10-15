import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chrimastsatastracker/features/mini_games/data/shared_preferences_mini_games_storage.dart';
import 'package:chrimastsatastracker/features/mini_games/domain/models/mini_game_record.dart';
import 'package:chrimastsatastracker/features/mini_games/presentation/controllers/mini_games_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SharedPreferencesMiniGamesStorage Persistence Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('1. Saves and loads game record cleanly', () async {
      const storage = SharedPreferencesMiniGamesStorage();

      const recordToSave = MiniGameRecord(
        memoryMatchCompletions: 3,
        memoryMatchBestMoves: 14,
        catchGiftsCompletions: 4,
        catchGiftsHighScore: 35,
        catchGiftsTotalGifts: 50,
      );

      await storage.saveRecord(recordToSave);
      final loadedRecord = await storage.loadRecord();

      expect(loadedRecord.memoryMatchCompletions, equals(3));
      expect(loadedRecord.memoryMatchBestMoves, equals(14));
      expect(loadedRecord.catchGiftsCompletions, equals(4));
      expect(loadedRecord.catchGiftsHighScore, equals(35));
      expect(loadedRecord.catchGiftsTotalGifts, equals(50));
    });

    test('2. Reconstructing controller restores persisted game records across app restart', () async {
      const storage = SharedPreferencesMiniGamesStorage();

      // Session 1: play games and update stats
      final controller1 = MiniGamesController(storage: storage);
      await controller1.initialize();
      await controller1.recordMemoryMatchWin(12);
      await controller1.recordCatchGiftsGameOver(score: 40, giftsCaught: 22);

      // Session 2: simulate app restart with brand new controller
      final controller2 = MiniGamesController(storage: storage);
      await controller2.initialize();

      expect(controller2.record.memoryMatchCompletions, equals(1));
      expect(controller2.record.memoryMatchBestMoves, equals(12));
      expect(controller2.record.catchGiftsCompletions, equals(1));
      expect(controller2.record.catchGiftsHighScore, equals(40));
      expect(controller2.record.catchGiftsTotalGifts, equals(22));
    });

    test('3. Handles corrupted or empty storage with safe fallback', () async {
      SharedPreferences.setMockInitialValues({
        'mini_games_memory_completions': -5, // invalid negative
        'mini_games_memory_best_moves': -1, // invalid negative moves
      });

      const storage = SharedPreferencesMiniGamesStorage();
      final record = await storage.loadRecord();

      expect(record.memoryMatchCompletions, equals(0)); // clamped to 0
      expect(record.memoryMatchBestMoves, isNull); // filtered negative
    });
  });
}
