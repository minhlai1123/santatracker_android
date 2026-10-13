import 'package:flutter/widgets.dart';

import '../../domain/models/santa_journey_status.dart';
import '../../domain/models/santa_stop.dart';
import '../../domain/models/santa_tracker_state.dart';
import '../../domain/services/network_status_provider.dart';
import '../../domain/services/santa_route_data.dart';

class SantaTrackerController extends ChangeNotifier {
  final NetworkStatusProvider? networkStatusProvider;
  late SantaTrackerState _state;
  bool _isAppInForeground = true;
  bool _isDisposed = false;

  SantaTrackerController({List<SantaStop>? stops, this.networkStatusProvider}) {
    final routeStops = stops ?? SantaRouteData.defaultStops;
    _state = SantaTrackerState.initial(
      routeStops,
      isOffline: networkStatusProvider?.isOffline ?? false,
    );
    networkStatusProvider?.addListener(_onNetworkStatusChanged);
  }

  SantaTrackerState get state => _state;

  bool get isAppInForeground => _isAppInForeground;

  bool get isDisposed => _isDisposed;

  bool get shouldAnimateMarker =>
      _isAppInForeground && _state.status == SantaJourneyStatus.inProgress;

  void _onNetworkStatusChanged() {
    if (_isDisposed) return;
    final offline = networkStatusProvider?.isOffline ?? false;
    if (_state.isOffline != offline) {
      _state = _state.copyWith(isOffline: offline);
      notifyListeners();
    }
  }

  void startJourney() {
    if (_isDisposed) return;
    if (_state.status != SantaJourneyStatus.notStarted) return;

    _state = _state.copyWith(status: SantaJourneyStatus.inProgress);
    notifyListeners();
  }

  void advanceToNextStop() {
    if (_isDisposed) return;
    if (_state.status != SantaJourneyStatus.inProgress) return;
    if (_state.currentStopIndex >= _state.stops.length - 1) return;

    final previousStop = _state.stops[_state.currentStopIndex];
    final nextIndex = _state.currentStopIndex + 1;
    final arrivedStop = _state.stops[nextIndex];

    final updatedCompletedIds = Set<String>.from(_state.completedStopIds)
      ..add(previousStop.id)
      ..add(arrivedStop.id);

    final reachedFinalStop = nextIndex == _state.stops.length - 1;

    _state = _state.copyWith(
      currentStopIndex: nextIndex,
      completedStopIds: updatedCompletedIds,
      status: reachedFinalStop
          ? SantaJourneyStatus.completed
          : SantaJourneyStatus.inProgress,
    );
    notifyListeners();
  }

  void pauseJourney() {
    if (_isDisposed) return;
    if (_state.status != SantaJourneyStatus.inProgress) return;

    _state = _state.copyWith(status: SantaJourneyStatus.paused);
    notifyListeners();
  }

  void resumeJourney() {
    if (_isDisposed) return;
    if (_state.status != SantaJourneyStatus.paused) return;

    _state = _state.copyWith(status: SantaJourneyStatus.inProgress);
    notifyListeners();
  }

  void resetJourney() {
    if (_isDisposed) return;
    _state = SantaTrackerState.initial(
      _state.stops,
      isOffline: _state.isOffline,
    );
    notifyListeners();
  }

  void handleAppLifecycleState(AppLifecycleState lifecycleState) {
    if (_isDisposed) return;
    final inForeground = lifecycleState == AppLifecycleState.resumed;
    if (_isAppInForeground != inForeground) {
      _isAppInForeground = inForeground;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    networkStatusProvider?.removeListener(_onNetworkStatusChanged);
    super.dispose();
  }
}
