import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/core/constants/app_strings.dart';
import 'package:chrimastsatastracker/core/theme/app_theme.dart';
import 'package:chrimastsatastracker/features/santa_tracker/domain/services/network_status_provider.dart';
import 'package:chrimastsatastracker/features/santa_tracker/presentation/controllers/santa_tracker_controller.dart';
import 'package:chrimastsatastracker/features/santa_tracker/presentation/screens/santa_tracker_screen.dart';

void main() {
  group('SantaTracker Lifecycle & Resource Cleanup Tests', () {
    testWidgets(
      'Pausing/resuming journey and backgrounding/resuming app preserves exact stop progress without auto-advancing',
      (WidgetTester tester) async {
        final controller = SantaTrackerController();
        addTearDown(() {
          if (!controller.isDisposed) {
            controller.dispose();
          }
        });

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.lightTheme,
            home: SantaTrackerScreen(controller: controller),
          ),
        );
        await tester.pump();

        // Start journey and advance 1 stop
        controller.startJourney();
        controller.advanceToNextStop();
        await tester.pump();

        expect(controller.state.currentStopIndex, equals(1));
        expect(controller.shouldAnimateMarker, isTrue);

        // Simulate app going to background (paused)
        tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
        await tester.pump(const Duration(seconds: 5));

        expect(controller.isAppInForeground, isFalse);
        expect(controller.shouldAnimateMarker, isFalse);
        // Progress must not change automatically in background
        expect(controller.state.currentStopIndex, equals(1));

        // Simulate app returning to foreground (resumed)
        tester.binding.handleAppLifecycleStateChanged(
          AppLifecycleState.resumed,
        );
        await tester.pump();

        expect(controller.isAppInForeground, isTrue);
        expect(controller.shouldAnimateMarker, isTrue);
        expect(controller.state.currentStopIndex, equals(1));
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'Unmounting SantaTrackerScreen disposes internal controller and marker animation cleanly without errors',
      (WidgetTester tester) async {
        final networkProvider = SimulatedNetworkStatusProvider(
          initialIsOffline: false,
        );
        addTearDown(networkProvider.dispose);

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.lightTheme,
            home: SantaTrackerScreen(networkStatusProvider: networkProvider),
          ),
        );
        await tester.pump();

        // Start journey so marker animation is actively repeating
        final startBtn = find.byKey(const Key('btn_start_journey'));
        await tester.ensureVisible(startBtn);
        await tester.tap(startBtn);
        await tester.pump(const Duration(milliseconds: 500));

        expect(find.text(AppStrings.statusInProgress), findsAtLeastNWidgets(1));

        // Unmount SantaTrackerScreen by replacing with a placeholder Scaffold
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: Text('Unmounted'))),
        );
        await tester.pumpAndSettle();

        // Toggling network status after unmount must not trigger listener errors
        networkProvider.setOffline(true);
        await tester.pump();

        expect(find.text('Unmounted'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  });
}
