import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/core/constants/app_strings.dart';
import 'package:chrimastsatastracker/core/theme/app_theme.dart';
import 'package:chrimastsatastracker/features/home/presentation/screens/home_screen.dart';
import 'package:chrimastsatastracker/features/santa_tracker/domain/services/network_status_provider.dart';
import 'package:chrimastsatastracker/features/santa_tracker/domain/services/santa_route_data.dart';
import 'package:chrimastsatastracker/features/santa_tracker/presentation/screens/santa_tracker_screen.dart';

void main() {
  Widget buildTrackerTestApp({NetworkStatusProvider? networkStatusProvider}) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: SantaTrackerScreen(networkStatusProvider: networkStatusProvider),
    );
  }

  group('SantaTrackerScreen Widget & Responsive Tests', () {
    const stops = SantaRouteData.defaultStops;

    testWidgets(
      '1-4. Renders title, simulation badge, custom map, current Santa marker, and initial journey metrics',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTrackerTestApp());
        await tester.pump();

        // 1. Title & Simulation badge
        expect(find.text(AppStrings.santaTrackerScreenTitle), findsOneWidget);
        expect(find.text(AppStrings.simulationBadgeLabel), findsOneWidget);

        // 2. Custom illustrated world map container & canvas
        expect(
          find.byKey(const Key('santa_world_map_container')),
          findsOneWidget,
        );
        expect(find.byKey(const Key('santa_world_map_canvas')), findsOneWidget);

        // 3. Current Santa marker
        expect(find.byKey(const Key('santa_current_marker')), findsOneWidget);

        // 4. Initial journey info
        expect(find.text(stops[0].fullLabel), findsOneWidget);
        expect(find.text(stops[1].fullLabel), findsOneWidget);
        expect(find.text(AppStrings.statusNotStarted), findsAtLeastNWidgets(1));
        expect(find.text('0 ${AppStrings.giftsUnitSuffix}'), findsOneWidget);
        expect(
          find.text(
            '~${stops[0].etaMinutesToNext} ${AppStrings.etaMinutesSuffix}',
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      '5-6. Start button begins journey and Next Stop button updates location, next stop, gifts, and ETA',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTrackerTestApp());
        await tester.pump();

        // 5. Tap "Bắt đầu hành trình"
        final startBtn = find.byKey(const Key('btn_start_journey'));
        await tester.ensureVisible(startBtn);
        await tester.tap(startBtn);
        await tester.pump();

        expect(find.text(AppStrings.statusInProgress), findsAtLeastNWidgets(1));

        // 6. Tap "Điểm dừng tiếp theo"
        final nextBtn = find.byKey(const Key('btn_next_stop'));
        await tester.ensureVisible(nextBtn);
        await tester.tap(nextBtn);
        await tester.pump();

        expect(find.text(stops[1].fullLabel), findsOneWidget);
        expect(find.text(stops[2].fullLabel), findsOneWidget);
        expect(
          find.text('180.000 ${AppStrings.giftsUnitSuffix}'),
          findsOneWidget,
        );
        expect(
          find.text(
            '~${stops[1].etaMinutesToNext} ${AppStrings.etaMinutesSuffix}',
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      '7-9. Pause disables advancing, and Resume restores inProgress state',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTrackerTestApp());
        await tester.pump();

        final startBtn = find.byKey(const Key('btn_start_journey'));
        await tester.ensureVisible(startBtn);
        await tester.tap(startBtn);
        await tester.pump();

        // 7. Tap "Tạm dừng"
        final pauseResumeBtn = find.byKey(
          const Key('btn_pause_resume_journey'),
        );
        await tester.ensureVisible(pauseResumeBtn);
        await tester.tap(pauseResumeBtn);
        await tester.pump();

        expect(find.text(AppStrings.statusPaused), findsAtLeastNWidgets(1));
        expect(find.text(AppStrings.resumeJourneyButton), findsOneWidget);

        // 8. While paused, Next Stop button is disabled and does not advance
        final nextBtn = find.byKey(const Key('btn_next_stop'));
        final ElevatedButton nextElevatedButton = tester.widget(nextBtn);
        expect(nextElevatedButton.onPressed, isNull);

        await tester.tap(nextBtn, warnIfMissed: false);
        await tester.pump();
        expect(find.text(stops[0].fullLabel), findsOneWidget);

        // 9. Tap "Tiếp tục"
        await tester.ensureVisible(pauseResumeBtn);
        await tester.tap(pauseResumeBtn);
        await tester.pump();

        expect(find.text(AppStrings.statusInProgress), findsAtLeastNWidgets(1));
      },
    );

    testWidgets(
      '10-11. Advancing through all stops shows Completed state, and Reset restores initial state',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTrackerTestApp());
        await tester.pump();

        final startBtn = find.byKey(const Key('btn_start_journey'));
        await tester.ensureVisible(startBtn);
        await tester.tap(startBtn);
        await tester.pump();

        final nextBtn = find.byKey(const Key('btn_next_stop'));
        for (int i = 0; i < stops.length - 1; i++) {
          await tester.ensureVisible(nextBtn);
          await tester.tap(nextBtn);
          await tester.pump();
        }

        // 10. Completed state displayed
        expect(find.text(AppStrings.statusCompleted), findsAtLeastNWidgets(2));
        expect(
          find.byKey(const Key('journey_completed_banner')),
          findsOneWidget,
        );
        expect(
          find.text('5.070.000 ${AppStrings.giftsUnitSuffix}'),
          findsOneWidget,
        );

        // 11. Tap "Đặt lại hành trình"
        final resetBtn = find.byKey(const Key('btn_reset_journey'));
        await tester.ensureVisible(resetBtn);
        await tester.tap(resetBtn);
        await tester.pump();

        expect(find.text(AppStrings.statusNotStarted), findsAtLeastNWidgets(1));
        expect(find.text(stops[0].fullLabel), findsOneWidget);
        expect(find.text('0 ${AppStrings.giftsUnitSuffix}'), findsOneWidget);
      },
    );

    testWidgets(
      '12. When mock network is offline, displays offline banner and manual controls still function',
      (WidgetTester tester) async {
        final offlineProvider = SimulatedNetworkStatusProvider(
          initialIsOffline: true,
        );
        addTearDown(offlineProvider.dispose);

        await tester.pumpWidget(
          buildTrackerTestApp(networkStatusProvider: offlineProvider),
        );
        await tester.pump();

        expect(find.byKey(const Key('santa_offline_banner')), findsOneWidget);
        expect(find.text(AppStrings.offlineSimulationBanner), findsOneWidget);

        // Manual controls still work normally while offline
        final startBtn = find.byKey(const Key('btn_start_journey'));
        await tester.ensureVisible(startBtn);
        await tester.tap(startBtn);
        await tester.pump();

        expect(find.text(AppStrings.statusInProgress), findsAtLeastNWidgets(1));

        final nextBtn = find.byKey(const Key('btn_next_stop'));
        await tester.ensureVisible(nextBtn);
        await tester.tap(nextBtn);
        await tester.pump();

        expect(find.text(stops[1].fullLabel), findsOneWidget);
      },
    );

    testWidgets('13. When mock network is online, offline banner is hidden', (
      WidgetTester tester,
    ) async {
      final onlineProvider = SimulatedNetworkStatusProvider(
        initialIsOffline: false,
      );
      addTearDown(onlineProvider.dispose);

      await tester.pumpWidget(
        buildTrackerTestApp(networkStatusProvider: onlineProvider),
      );
      await tester.pump();

      expect(find.byKey(const Key('santa_offline_banner')), findsNothing);
      expect(find.text(AppStrings.offlineSimulationBanner), findsNothing);
    });

    testWidgets(
      '14-15. HomeScreen navigates to SantaTrackerScreen and keeps remaining 3 features as Coming Soon',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.lightTheme,
            home: HomeScreen(clock: () => DateTime(2026, 12, 10, 12, 0, 0)),
          ),
        );
        await tester.pumpAndSettle();

        // 15. Verify remaining 2 features are still Coming Soon
        expect(find.text(AppStrings.gamesFeatureTitle), findsOneWidget);
        expect(find.text(AppStrings.adventFeatureTitle), findsOneWidget);
        expect(find.text(AppStrings.comingSoonBadge), findsNWidgets(2));

        // 14. Navigate to SantaTrackerScreen and back
        final openTrackerBtn = find.byKey(const Key('btn_open_santa_tracker'));
        await tester.ensureVisible(openTrackerBtn);
        await tester.tap(openTrackerBtn);
        await tester.pumpAndSettle();

        expect(find.text(AppStrings.simulationBadgeLabel), findsOneWidget);

        final backBtn = find.text(AppStrings.backToHomeButton);
        await tester.ensureVisible(backBtn);
        await tester.tap(backBtn);
        await tester.pumpAndSettle();

        expect(
          find.byKey(const Key('home_santa_tracker_card')),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      '16a. Responsive check on small phone screen (360x640) has no overflow',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(360, 640);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        final offlineProvider = SimulatedNetworkStatusProvider(
          initialIsOffline: true,
        );
        addTearDown(offlineProvider.dispose);

        await tester.pumpWidget(
          buildTrackerTestApp(networkStatusProvider: offlineProvider),
        );
        await tester.pump();

        expect(find.text(AppStrings.simulationBadgeLabel), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      '16b. Responsive check on standard phone screen (390x844) has no overflow',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(buildTrackerTestApp());
        await tester.pump();

        expect(find.text(AppStrings.simulationBadgeLabel), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      '16c. Responsive check on tablet screen (768x1024) has no overflow',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(768, 1024);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(buildTrackerTestApp());
        await tester.pump();

        expect(find.text(AppStrings.simulationBadgeLabel), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  });
}
