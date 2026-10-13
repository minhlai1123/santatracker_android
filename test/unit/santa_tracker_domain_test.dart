import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/core/constants/app_strings.dart';
import 'package:chrimastsatastracker/features/santa_tracker/domain/models/santa_journey_status.dart';
import 'package:chrimastsatastracker/features/santa_tracker/domain/models/santa_stop.dart';
import 'package:chrimastsatastracker/features/santa_tracker/domain/models/santa_tracker_state.dart';
import 'package:chrimastsatastracker/features/santa_tracker/domain/services/network_status_provider.dart';
import 'package:chrimastsatastracker/features/santa_tracker/domain/services/santa_route_data.dart';
import 'package:chrimastsatastracker/features/santa_tracker/presentation/controllers/santa_tracker_controller.dart';

void main() {
  group('SantaRouteData & SantaStop Validation Tests', () {
    const stops = SantaRouteData.defaultStops;

    test('1. Route data contains at least 12 stops', () {
      expect(stops.length, greaterThanOrEqualTo(12));
    });

    test('2. Every stop has non-empty id, name, region, description, unique id, and sequential order', () {
      final seenIds = <String>{};
      for (int i = 0; i < stops.length; i++) {
        final stop = stops[i];
        expect(stop.id.trim(), isNotEmpty);
        expect(stop.name.trim(), isNotEmpty);
        expect(stop.region.trim(), isNotEmpty);
        expect(stop.description.trim(), isNotEmpty);
        expect(stop.order, equals(i));
        expect(
          seenIds.add(stop.id),
          isTrue,
          reason: 'Duplicate stop id: ${stop.id}',
        );
      }
    });

    test('3. Every stop has normalizedX and normalizedY within [0.0, 1.0]', () {
      for (final stop in stops) {
        expect(stop.normalizedX, inInclusiveRange(0.0, 1.0));
        expect(stop.normalizedY, inInclusiveRange(0.0, 1.0));
      }
    });

    test(
      '4. Every stop has non-negative giftsToDeliver and etaMinutesToNext',
      () {
        for (final stop in stops) {
          expect(stop.giftsToDeliver, greaterThanOrEqualTo(0));
          expect(stop.etaMinutesToNext, greaterThanOrEqualTo(0));
        }
        // Delivery stops after North Pole have positive gift counts
        for (int i = 1; i < stops.length; i++) {
          expect(stops[i].giftsToDeliver, greaterThan(0));
        }
      },
    );

    test('SantaStop value equality and formatting work as expected', () {
      final first = stops.first;
      final copy = SantaStop(
        id: first.id,
        name: first.name,
        region: first.region,
        description: first.description,
        normalizedX: first.normalizedX,
        normalizedY: first.normalizedY,
        giftsToDeliver: first.giftsToDeliver,
        etaMinutesToNext: first.etaMinutesToNext,
        order: first.order,
      );
      expect(first, equals(copy));
      expect(first.hashCode, equals(copy.hashCode));
      expect(first.fullLabel, equals('${first.name}, ${first.region}'));
      expect(first.toString(), contains(first.id));
    });
  });

  group('SantaTrackerController Simulation Logic Tests', () {
    late SantaTrackerController controller;
    const stops = SantaRouteData.defaultStops;

    setUp(() {
      controller = SantaTrackerController();
    });

    tearDown(() {
      if (!controller.isDisposed) {
        controller.dispose();
      }
    });

    test('5. Initial state is notStarted, at first stop, next stop is second stop, and giftsDelivered is 0', () {
      final state = controller.state;
      expect(state.status, equals(SantaJourneyStatus.notStarted));
      expect(state.currentStopIndex, equals(0));
      expect(state.currentStop, equals(stops[0]));
      expect(state.nextStop, equals(stops[1]));
      expect(state.giftsDelivered, equals(0));
      expect(state.etaMinutes, equals(stops[0].etaMinutesToNext));
      expect(state.status.label, equals(AppStrings.statusNotStarted));
    });

    test(
      '6. startJourney() transitions status from notStarted to inProgress',
      () {
        controller.startJourney();
        expect(controller.state.status, equals(SantaJourneyStatus.inProgress));
        expect(controller.state.currentStopIndex, equals(0));
        expect(
          controller.state.status.label,
          equals(AppStrings.statusInProgress),
        );
      },
    );

    test('7. advanceToNextStop() does nothing when status is notStarted', () {
      controller.advanceToNextStop();
      expect(controller.state.status, equals(SantaJourneyStatus.notStarted));
      expect(controller.state.currentStopIndex, equals(0));
      expect(controller.state.giftsDelivered, equals(0));
    });

    test(
      '8. advanceToNextStop() increments stop index by 1 when inProgress',
      () {
        controller.startJourney();
        controller.advanceToNextStop();

        expect(controller.state.currentStopIndex, equals(1));
        expect(controller.state.currentStop, equals(stops[1]));
        expect(controller.state.nextStop, equals(stops[2]));
        expect(controller.state.etaMinutes, equals(stops[1].etaMinutesToNext));
      },
    );

    test('9. Simulated gifts increase accurately per completed stop and never double-count', () {
      controller.startJourney();
      int expectedGifts = stops[0].giftsToDeliver;

      for (int i = 1; i < stops.length; i++) {
        controller.advanceToNextStop();
        expectedGifts += stops[i].giftsToDeliver;
        expect(
          controller.state.giftsDelivered,
          equals(expectedGifts),
          reason: 'Gift count mismatch at stop index $i',
        );
      }

      // Pause/resume or extra start calls must never duplicate gifts
      final totalAtEnd = controller.state.giftsDelivered;
      controller.startJourney();
      controller.advanceToNextStop();
      expect(controller.state.giftsDelivered, equals(totalAtEnd));
    });

    test('10. pauseJourney() transitions to paused and preserves current stop and gifts', () {
      controller.startJourney();
      controller.advanceToNextStop();
      final giftsBeforePause = controller.state.giftsDelivered;

      controller.pauseJourney();
      expect(controller.state.status, equals(SantaJourneyStatus.paused));
      expect(controller.state.status.label, equals(AppStrings.statusPaused));
      expect(controller.state.currentStopIndex, equals(1));
      expect(controller.state.giftsDelivered, equals(giftsBeforePause));
    });

    test(
      '11. When paused, advanceToNextStop() does not change position or gifts',
      () {
        controller.startJourney();
        controller.advanceToNextStop();
        controller.pauseJourney();

        final indexBefore = controller.state.currentStopIndex;
        final giftsBefore = controller.state.giftsDelivered;

        controller.advanceToNextStop();

        expect(controller.state.currentStopIndex, equals(indexBefore));
        expect(controller.state.giftsDelivered, equals(giftsBefore));
        expect(controller.state.status, equals(SantaJourneyStatus.paused));
      },
    );

    test('12. resumeJourney() returns to inProgress at exact paused stop and allows advancing', () {
      controller.startJourney();
      controller.advanceToNextStop();
      controller.pauseJourney();

      controller.resumeJourney();
      expect(controller.state.status, equals(SantaJourneyStatus.inProgress));
      expect(controller.state.currentStopIndex, equals(1));

      controller.advanceToNextStop();
      expect(controller.state.currentStopIndex, equals(2));
    });

    test('13. Reaching the final stop transitions status to completed and sets nextStop to null', () {
      controller.startJourney();
      for (int i = 0; i < stops.length - 1; i++) {
        controller.advanceToNextStop();
      }

      expect(controller.state.currentStopIndex, equals(stops.length - 1));
      expect(controller.state.status, equals(SantaJourneyStatus.completed));
      expect(controller.state.status.label, equals(AppStrings.statusCompleted));
      expect(controller.state.nextStop, isNull);
      expect(controller.state.etaMinutes, equals(0));
      expect(
        controller.state.nextDestinationDisplay,
        equals(AppStrings.statusCompleted),
      );
      expect(controller.state.etaDisplay, equals(AppStrings.statusCompleted));
    });

    test('14. Calling advanceToNextStop() repeatedly when completed does not throw or add extra gifts', () {
      controller.startJourney();
      for (int i = 0; i < stops.length - 1; i++) {
        controller.advanceToNextStop();
      }

      final finalGifts = controller.state.giftsDelivered;
      final finalIndex = controller.state.currentStopIndex;

      for (int extra = 0; extra < 5; extra++) {
        controller.advanceToNextStop();
      }

      expect(controller.state.currentStopIndex, equals(finalIndex));
      expect(controller.state.giftsDelivered, equals(finalGifts));
      expect(controller.state.status, equals(SantaJourneyStatus.completed));
    });

    test('15. resetJourney() restores all state back to initial values', () {
      controller.startJourney();
      controller.advanceToNextStop();
      controller.advanceToNextStop();
      expect(controller.state.currentStopIndex, equals(2));
      expect(controller.state.giftsDelivered, greaterThan(0));

      controller.resetJourney();

      expect(controller.state.status, equals(SantaJourneyStatus.notStarted));
      expect(controller.state.currentStopIndex, equals(0));
      expect(controller.state.currentStop, equals(stops[0]));
      expect(controller.state.nextStop, equals(stops[1]));
      expect(controller.state.giftsDelivered, equals(0));
      expect(controller.state.completedStopIds, isEmpty);
    });

    test('16. NetworkStatusProvider mock accurately reflects offline and online transitions', () {
      final networkProvider = SimulatedNetworkStatusProvider(
        initialIsOffline: true,
      );
      final trackedController = SantaTrackerController(
        networkStatusProvider: networkProvider,
      );

      expect(trackedController.state.isOffline, isTrue);

      networkProvider.setOffline(false);
      expect(trackedController.state.isOffline, isFalse);

      networkProvider.setOffline(true);
      expect(trackedController.state.isOffline, isTrue);

      trackedController.dispose();
      networkProvider.dispose();
    });

    test('SantaTrackerState.formatNumber formats thousands with dots', () {
      expect(SantaTrackerState.formatNumber(0), equals('0'));
      expect(SantaTrackerState.formatNumber(950), equals('950'));
      expect(SantaTrackerState.formatNumber(180000), equals('180.000'));
      expect(SantaTrackerState.formatNumber(5070000), equals('5.070.000'));
    });
  });
}
