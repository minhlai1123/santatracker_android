import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../../domain/models/catch_gifts_state.dart';
import '../../domain/services/catch_gifts_engine.dart';
import 'mini_games_controller.dart';

class CatchGiftsController extends ChangeNotifier {
  final MiniGamesController? statsController;
  final int durationSeconds;
  final Random? random;

  late CatchGiftsState _state;
  Timer? _gameTimer;
  bool _gameOverRecorded = false;
  bool _isDisposed = false;

  CatchGiftsController({
    this.statsController,
    this.durationSeconds = CatchGiftsEngine.defaultDurationSeconds,
    this.random,
  }) {
    _state = CatchGiftsState.initial(durationSeconds: durationSeconds);
  }

  CatchGiftsState get state => _state;
  bool get isDisposed => _isDisposed;

  void startGame() {
    if (_isDisposed) return;
    _gameTimer?.cancel();
    _gameTimer = null;
    _gameOverRecorded = false;

    _state = CatchGiftsEngine.startSession(
      durationSeconds: durationSeconds,
      random: random,
    );
    notifyListeners();

    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isDisposed) {
        timer.cancel();
        return;
      }
      _handleTick();
    });
  }

  void manualTick() {
    if (_isDisposed) return;
    _handleTick();
  }

  void _handleTick() {
    final nextState = CatchGiftsEngine.tickSecond(_state, random: random);
    _state = nextState;

    if (_state.isGameOver) {
      _gameTimer?.cancel();
      _gameTimer = null;
      if (!_gameOverRecorded) {
        _gameOverRecorded = true;
        statsController?.recordCatchGiftsGameOver(
          score: _state.score,
          giftsCaught: _state.totalGiftsCaught,
        );
      }
    }

    notifyListeners();
  }

  void tapGift(int giftId) {
    if (_isDisposed || !_state.isPlaying || _state.isGameOver) return;

    final nextState = CatchGiftsEngine.tapTarget(_state, giftId);
    if (nextState != _state) {
      _state = nextState;
      notifyListeners();
    }
  }

  void tapEmptyArea() {
    if (_isDisposed || !_state.isPlaying || _state.isGameOver) return;
    final nextState = CatchGiftsEngine.tapEmptyArea(_state);
    if (nextState != _state) {
      _state = nextState;
      notifyListeners();
    }
  }

  void reset() {
    _gameTimer?.cancel();
    _gameTimer = null;
    _gameOverRecorded = false;
    _state = CatchGiftsState.initial(durationSeconds: durationSeconds);
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _gameTimer?.cancel();
    _gameTimer = null;
    super.dispose();
  }
}
