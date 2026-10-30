import 'package:flutter/foundation.dart';

import '../../data/mini_games_storage.dart';
import '../../data/shared_preferences_mini_games_storage.dart';
import '../../domain/models/mini_game_record.dart';

class MiniGamesController extends ChangeNotifier {
  final MiniGamesStorage _storage;

  MiniGameRecord _record = const MiniGameRecord.initial();
  bool _isLoading = true;

  MiniGamesController({MiniGamesStorage? storage})
    : _storage = storage ?? const SharedPreferencesMiniGamesStorage();

  MiniGameRecord get record => _record;
  bool get isLoading => _isLoading;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    try {
      _record = await _storage.loadRecord();
    } catch (e) {
      debugPrint('MiniGamesController: Error loading data: $e');
      _record = const MiniGameRecord.initial();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> recordMemoryMatchWin(int moves) async {
    if (moves <= 0) return;

    final nextCompletions = _record.memoryMatchCompletions + 1;
    final int nextBestMoves;
    if (_record.memoryMatchBestMoves == null) {
      nextBestMoves = moves;
    } else {
      nextBestMoves = moves < _record.memoryMatchBestMoves!
          ? moves
          : _record.memoryMatchBestMoves!;
    }

    _record = _record.copyWith(
      memoryMatchCompletions: nextCompletions,
      memoryMatchBestMoves: () => nextBestMoves,
    );
    notifyListeners();

    await _storage.saveRecord(_record);
  }

  Future<void> recordCatchGiftsGameOver({
    required int score,
    required int giftsCaught,
  }) async {
    final nextCompletions = _record.catchGiftsCompletions + 1;
    final nextHighScore = score > _record.catchGiftsHighScore
        ? score
        : _record.catchGiftsHighScore;
    final nextTotalGifts = _record.catchGiftsTotalGifts + giftsCaught;

    _record = _record.copyWith(
      catchGiftsCompletions: nextCompletions,
      catchGiftsHighScore: nextHighScore,
      catchGiftsTotalGifts: nextTotalGifts,
    );
    notifyListeners();

    await _storage.saveRecord(_record);
  }
}
