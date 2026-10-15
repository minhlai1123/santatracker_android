import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../../domain/models/memory_match_state.dart';
import '../../domain/services/memory_match_engine.dart';
import 'mini_games_controller.dart';

class MemoryMatchController extends ChangeNotifier {
  final MiniGamesController? statsController;
  final Duration mismatchDelay;
  final Random? random;

  late MemoryMatchState _state;
  Timer? _mismatchTimer;
  bool _winRecorded = false;
  bool _isDisposed = false;

  MemoryMatchController({
    this.statsController,
    this.mismatchDelay = const Duration(milliseconds: 700),
    this.random,
  }) {
    _state = MemoryMatchEngine.createInitialState(random: random);
  }

  MemoryMatchState get state => _state;

  void flipCard(int index) {
    if (_isDisposed) return;
    if (_state.isBusyWaiting || _state.isCompleted) return;

    final nextState = MemoryMatchEngine.flipCard(_state, index);
    if (nextState == _state) return;

    _state = nextState;
    notifyListeners();

    if (_state.isBusyWaiting) {
      _mismatchTimer?.cancel();
      if (mismatchDelay == Duration.zero) {
        _resolveMismatch();
      } else {
        _mismatchTimer = Timer(mismatchDelay, _resolveMismatch);
      }
    } else if (_state.isCompleted && !_winRecorded) {
      _winRecorded = true;
      statsController?.recordMemoryMatchWin(_state.moves);
    }
  }

  void _resolveMismatch() {
    if (_isDisposed) return;
    if (!_state.isBusyWaiting) return;

    _state = MemoryMatchEngine.resolveMismatch(_state);
    notifyListeners();
  }

  void reset() {
    _mismatchTimer?.cancel();
    _mismatchTimer = null;
    _winRecorded = false;
    _state = MemoryMatchEngine.createInitialState(random: random);
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _mismatchTimer?.cancel();
    _mismatchTimer = null;
    super.dispose();
  }
}
