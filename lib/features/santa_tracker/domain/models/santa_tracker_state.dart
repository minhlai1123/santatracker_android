import 'package:flutter/foundation.dart';

import '../../../../core/constants/app_strings.dart';
import 'santa_journey_status.dart';
import 'santa_stop.dart';

class SantaTrackerState {
  final List<SantaStop> stops;
  final int currentStopIndex;
  final SantaJourneyStatus status;
  final Set<String> completedStopIds;
  final bool isOffline;

  SantaTrackerState({
    required List<SantaStop> stops,
    required this.currentStopIndex,
    required this.status,
    required Set<String> completedStopIds,
    this.isOffline = false,
  }) : assert(stops.isNotEmpty, 'stops cannot be empty'),
       assert(
         currentStopIndex >= 0 && currentStopIndex < stops.length,
         'currentStopIndex must be valid within stops',
       ),
       stops = List.unmodifiable(stops),
       completedStopIds = Set.unmodifiable(completedStopIds);

  factory SantaTrackerState.initial(
    List<SantaStop> stops, {
    bool isOffline = false,
  }) {
    return SantaTrackerState(
      stops: stops,
      currentStopIndex: 0,
      status: SantaJourneyStatus.notStarted,
      completedStopIds: const <String>{},
      isOffline: isOffline,
    );
  }

  SantaStop get currentStop => stops[currentStopIndex];

  SantaStop? get nextStop {
    if (status == SantaJourneyStatus.completed) {
      return null;
    }
    final nextIndex = currentStopIndex + 1;
    if (nextIndex < stops.length) {
      return stops[nextIndex];
    }
    return null;
  }

  int get giftsDelivered {
    return stops
        .where((stop) => completedStopIds.contains(stop.id))
        .fold<int>(0, (sum, stop) => sum + stop.giftsToDeliver);
  }

  int get etaMinutes {
    if (status == SantaJourneyStatus.completed || nextStop == null) {
      return 0;
    }
    return currentStop.etaMinutesToNext;
  }

  int get totalStops => stops.length;

  int get completedStopsCount => completedStopIds.length;

  bool get isNotStarted => status == SantaJourneyStatus.notStarted;
  bool get isInProgress => status == SantaJourneyStatus.inProgress;
  bool get isPaused => status == SantaJourneyStatus.paused;
  bool get isCompleted => status == SantaJourneyStatus.completed;

  bool get canStart => status == SantaJourneyStatus.notStarted;
  bool get canAdvance =>
      status == SantaJourneyStatus.inProgress &&
      currentStopIndex < stops.length - 1;
  bool get canPause => status == SantaJourneyStatus.inProgress;
  bool get canResume => status == SantaJourneyStatus.paused;
  bool get canReset => status != SantaJourneyStatus.notStarted;

  bool isStopCompleted(String stopId) => completedStopIds.contains(stopId);

  String get currentLocationDisplay => currentStop.fullLabel;

  String get nextDestinationDisplay {
    if (isCompleted || nextStop == null) {
      return AppStrings.statusCompleted;
    }
    return nextStop!.fullLabel;
  }

  String get etaDisplay {
    if (isCompleted || nextStop == null) {
      return AppStrings.statusCompleted;
    }
    return '~$etaMinutes ${AppStrings.etaMinutesSuffix}';
  }

  String get giftsDeliveredDisplay =>
      '${formatNumber(giftsDelivered)} ${AppStrings.giftsUnitSuffix}';

  String get progressFractionDisplay =>
      '${currentStopIndex + 1} / ${stops.length}';

  static String formatNumber(int number) {
    final digits = number.abs().toString();
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(digits[i]);
    }
    return number < 0 ? '-$buffer' : buffer.toString();
  }

  SantaTrackerState copyWith({
    List<SantaStop>? stops,
    int? currentStopIndex,
    SantaJourneyStatus? status,
    Set<String>? completedStopIds,
    bool? isOffline,
  }) {
    return SantaTrackerState(
      stops: stops ?? this.stops,
      currentStopIndex: currentStopIndex ?? this.currentStopIndex,
      status: status ?? this.status,
      completedStopIds: completedStopIds ?? this.completedStopIds,
      isOffline: isOffline ?? this.isOffline,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SantaTrackerState &&
        listEquals(other.stops, stops) &&
        other.currentStopIndex == currentStopIndex &&
        other.status == status &&
        setEquals(other.completedStopIds, completedStopIds) &&
        other.isOffline == isOffline;
  }

  @override
  int get hashCode => Object.hash(
    Object.hashAll(stops),
    currentStopIndex,
    status,
    Object.hashAll(completedStopIds),
    isOffline,
  );
}
