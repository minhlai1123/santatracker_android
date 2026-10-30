import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/models/mini_game_record.dart';
import 'mini_games_storage.dart';

class SharedPreferencesMiniGamesStorage implements MiniGamesStorage {
  static const String keyMemoryCompletions = 'mini_games_memory_completions';
  static const String keyMemoryBestMoves = 'mini_games_memory_best_moves';
  static const String keyCatchCompletions = 'mini_games_catch_completions';
  static const String keyCatchHighScore = 'mini_games_catch_high_score';
  static const String keyCatchTotalGifts = 'mini_games_catch_total_gifts';

  const SharedPreferencesMiniGamesStorage();

  @override
  Future<MiniGameRecord> loadRecord() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final memoryCompletions = prefs.getInt(keyMemoryCompletions) ?? 0;
      final memoryBestMoves = prefs.getInt(keyMemoryBestMoves);
      final catchCompletions = prefs.getInt(keyCatchCompletions) ?? 0;
      final catchHighScore = prefs.getInt(keyCatchHighScore) ?? 0;
      final catchTotalGifts = prefs.getInt(keyCatchTotalGifts) ?? 0;

      return MiniGameRecord(
        memoryMatchCompletions: memoryCompletions.clamp(0, 999999),
        memoryMatchBestMoves: memoryBestMoves != null && memoryBestMoves > 0
            ? memoryBestMoves
            : null,
        catchGiftsCompletions: catchCompletions.clamp(0, 999999),
        catchGiftsHighScore: catchHighScore.clamp(0, 999999),
        catchGiftsTotalGifts: catchTotalGifts.clamp(0, 999999),
      );
    } catch (e, stackTrace) {
      debugPrint(
        'SharedPreferencesMiniGamesStorage: Failed to load records: $e\n$stackTrace',
      );
      return const MiniGameRecord.initial();
    }
  }

  @override
  Future<void> saveRecord(MiniGameRecord record) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setInt(
        keyMemoryCompletions,
        record.memoryMatchCompletions.clamp(0, 999999),
      );
      if (record.memoryMatchBestMoves != null) {
        await prefs.setInt(keyMemoryBestMoves, record.memoryMatchBestMoves!);
      }
      await prefs.setInt(
        keyCatchCompletions,
        record.catchGiftsCompletions.clamp(0, 999999),
      );
      await prefs.setInt(
        keyCatchHighScore,
        record.catchGiftsHighScore.clamp(0, 999999),
      );
      await prefs.setInt(
        keyCatchTotalGifts,
        record.catchGiftsTotalGifts.clamp(0, 999999),
      );
    } catch (e, stackTrace) {
      debugPrint(
        'SharedPreferencesMiniGamesStorage: Failed to save records: $e\n$stackTrace',
      );
    }
  }
}
