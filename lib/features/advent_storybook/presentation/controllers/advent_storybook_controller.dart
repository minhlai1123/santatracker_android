import 'package:flutter/foundation.dart';

import '../../../mini_games/domain/models/mini_game_record.dart';
import '../../../mini_games/presentation/controllers/mini_games_controller.dart';
import '../../data/advent_storage.dart';
import '../../data/shared_preferences_advent_storage.dart';
import '../../domain/models/advent_chapter.dart';
import '../../domain/models/advent_storybook_state.dart';
import '../../domain/services/advent_storybook_data.dart';
import '../../domain/services/advent_unlock_rules.dart';

class AdventStorybookController extends ChangeNotifier {
  final AdventStorage storage;
  final MiniGamesController? gamesController;

  late AdventStorybookState _state;
  bool _isDisposed = false;

  AdventStorybookController({
    AdventStorage? storage,
    this.gamesController,
    List<AdventChapter>? customChapters,
  }) : storage = storage ?? const SharedPreferencesAdventStorage() {
    _state = AdventStorybookState(
      chapters: customChapters ?? AdventStorybookData.allChapters,
      unlockedChapterDays: const {1},
      readChapterDays: const {},
      isLoading: true,
    );
  }

  AdventStorybookState get state => _state;

  Future<void> initialize() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    try {
      final loadedUnlocked = await storage.loadUnlockedDays();
      final loadedRead = await storage.loadReadDays();

      // Ensure Day 1 is always unlocked
      final currentUnlocked = Set<int>.from(loadedUnlocked)..add(1);
      final currentRead = Set<int>.from(loadedRead);

      // Evaluate against current mini game records
      final gameRecord =
          gamesController?.record ?? const MiniGameRecord.initial();
      final evaluatedUnlocked = AdventUnlockRules.evaluateAllUnlocked(
        record: gameRecord,
        existingUnlocked: currentUnlocked,
        readDays: currentRead,
      );

      // Save if new chapters were unlocked
      if (evaluatedUnlocked.length > loadedUnlocked.length) {
        await storage.saveUnlockedDays(evaluatedUnlocked);
      }

      _state = _state.copyWith(
        unlockedChapterDays: evaluatedUnlocked,
        readChapterDays: currentRead,
        isLoading: false,
      );
    } catch (e, stackTrace) {
      debugPrint(
        'AdventStorybookController: Initialization error: $e\n$stackTrace',
      );
      _state = _state.copyWith(
        unlockedChapterDays: {1},
        readChapterDays: {},
        isLoading: false,
      );
    }

    if (!_isDisposed) {
      notifyListeners();
    }
  }

  Future<void> syncWithMiniGames(MiniGameRecord record) async {
    if (_isDisposed) return;

    final evaluatedUnlocked = AdventUnlockRules.evaluateAllUnlocked(
      record: record,
      existingUnlocked: _state.unlockedChapterDays,
      readDays: _state.readChapterDays,
    );

    if (evaluatedUnlocked.length > _state.unlockedChapterDays.length) {
      _state = _state.copyWith(unlockedChapterDays: evaluatedUnlocked);
      notifyListeners();
      await storage.saveUnlockedDays(evaluatedUnlocked);
    }
  }

  Future<void> markChapterAsRead(int dayNumber) async {
    if (_isDisposed) return;
    if (dayNumber < 1 || dayNumber > 24) return;
    if (!_state.isChapterUnlocked(dayNumber)) return;
    if (_state.isChapterRead(dayNumber)) return; // idempotent

    final nextRead = Set<int>.from(_state.readChapterDays)..add(dayNumber);

    // Re-evaluate unlock rules with new read count
    final gameRecord =
        gamesController?.record ?? const MiniGameRecord.initial();
    final evaluatedUnlocked = AdventUnlockRules.evaluateAllUnlocked(
      record: gameRecord,
      existingUnlocked: _state.unlockedChapterDays,
      readDays: nextRead,
    );

    _state = _state.copyWith(
      readChapterDays: nextRead,
      unlockedChapterDays: evaluatedUnlocked,
    );
    notifyListeners();

    await storage.saveReadDays(nextRead);
    if (evaluatedUnlocked.length > _state.unlockedChapterDays.length) {
      await storage.saveUnlockedDays(evaluatedUnlocked);
    }
  }

  void selectChapter(int dayNumber) {
    if (dayNumber < 1 || dayNumber > 24) return;
    final chapter = AdventStorybookData.getChapter(dayNumber);
    _state = _state.copyWith(selectedChapter: () => chapter);
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
