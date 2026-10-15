import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/core/constants/app_strings.dart';
import 'package:chrimastsatastracker/core/theme/app_theme.dart';
import 'package:chrimastsatastracker/features/home/presentation/screens/home_screen.dart';

void main() {
  Widget buildTestableWidget({DateTime Function()? clock}) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: HomeScreen(clock: clock ?? () => DateTime(2026, 12, 1, 10, 0, 0)),
    );
  }

  group('HomeScreen Widget Tests', () {
    testWidgets('renders all main sections and buttons properly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      // App name in AppBar and Header
      expect(find.text(AppStrings.appName), findsAtLeastNWidgets(1));

      // Header tagline
      expect(find.text(AppStrings.festiveTagline), findsOneWidget);

      // Countdown preview card
      expect(find.text(AppStrings.countdownPreviewTitle), findsOneWidget);
      expect(find.text(AppStrings.countdownPreviewSubtitle), findsOneWidget);
      expect(find.text(AppStrings.openCountdownButton), findsOneWidget);

      // Time unit labels inside preview
      expect(find.text(AppStrings.daysLabel), findsOneWidget);
      expect(find.text(AppStrings.hoursLabel), findsOneWidget);
      expect(find.text(AppStrings.minutesLabel), findsOneWidget);
      expect(find.text(AppStrings.secondsLabel), findsOneWidget);

      // Active feature cards (Phase 3, 4, 5)
      expect(find.text(AppStrings.trackerFeatureTitle), findsOneWidget);
      expect(find.text(AppStrings.villageFeatureTitle), findsOneWidget);
      expect(find.text(AppStrings.gamesFeatureTitle), findsOneWidget);
      expect(find.text(AppStrings.adventFeatureTitle), findsOneWidget);

      // All 4 feature cards have "Hoạt động" active badge
      expect(find.text('Hoạt động'), findsNWidgets(4));

      // Open buttons for all features
      expect(find.text(AppStrings.openSantaTrackerButton), findsOneWidget);
      expect(find.text(AppStrings.openVillageButton), findsOneWidget);
      expect(find.text(AppStrings.openMiniGamesButton), findsOneWidget);
      expect(find.text(AppStrings.openAdventButton), findsOneWidget);

      // About button & holiday greeting
      expect(find.text(AppStrings.aboutAppButton), findsAtLeastNWidgets(1));
      expect(find.text(AppStrings.holidayGreeting), findsOneWidget);
    });

    testWidgets('navigates to CountdownScreen and returns to HomeScreen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      // Tap "Xem Đếm Ngược"
      final openCountdownBtn = find.text(AppStrings.openCountdownButton);
      expect(openCountdownBtn, findsOneWidget);
      await tester.ensureVisible(openCountdownBtn);
      await tester.tap(openCountdownBtn);
      await tester.pumpAndSettle();

      // Verify on CountdownScreen
      expect(find.text(AppStrings.countdownScreenTitle), findsOneWidget);

      // Tap "Quay lại Trang Chủ"
      final backBtn = find.text(AppStrings.backToHomeButton);
      expect(backBtn, findsOneWidget);
      await tester.ensureVisible(backBtn);
      await tester.tap(backBtn);
      await tester.pumpAndSettle();

      // Verify back on HomeScreen
      expect(find.text(AppStrings.openCountdownButton), findsOneWidget);
    });

    testWidgets('navigates to SantaTrackerScreen and returns to HomeScreen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      // Tap "Mở Santa Tracker"
      final openTrackerBtn = find.text(AppStrings.openSantaTrackerButton);
      expect(openTrackerBtn, findsOneWidget);
      await tester.ensureVisible(openTrackerBtn);
      await tester.tap(openTrackerBtn);
      await tester.pumpAndSettle();

      // Verify on SantaTrackerScreen
      expect(find.text(AppStrings.simulationBadgeLabel), findsOneWidget);

      // Tap "Quay lại Trang Chủ"
      final backBtn = find.text(AppStrings.backToHomeButton);
      expect(backBtn, findsOneWidget);
      await tester.ensureVisible(backBtn);
      await tester.tap(backBtn);
      await tester.pumpAndSettle();

      // Verify back on HomeScreen
      expect(find.text(AppStrings.openSantaTrackerButton), findsOneWidget);
    });

    testWidgets(
      'navigates to NorthPoleVillageScreen and returns to HomeScreen',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTestableWidget());
        await tester.pumpAndSettle();

        // Tap "Khám Phá Ngôi Làng"
        final openVillageBtn = find.byKey(const Key('btn_open_village'));
        expect(openVillageBtn, findsOneWidget);
        await tester.ensureVisible(openVillageBtn);
        await tester.tap(openVillageBtn);
        await tester.pumpAndSettle();

        // Verify on NorthPoleVillageScreen
        expect(
          find.text(AppStrings.villageScreenTitle),
          findsAtLeastNWidgets(1),
        );

        // Tap "Quay lại Trang Chủ"
        final backBtn = find.text(AppStrings.backToHomeButton);
        expect(backBtn, findsOneWidget);
        await tester.ensureVisible(backBtn);
        await tester.tap(backBtn);
        await tester.pumpAndSettle();

        // Verify back on HomeScreen
        expect(find.byKey(const Key('btn_open_village')), findsOneWidget);
      },
    );

    testWidgets(
      'navigates to ChristmasMiniGamesScreen and returns to HomeScreen',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTestableWidget());
        await tester.pumpAndSettle();

        // Tap "Chơi Trò Chơi"
        final openGamesBtn = find.byKey(const Key('btn_open_mini_games'));
        expect(openGamesBtn, findsOneWidget);
        await tester.ensureVisible(openGamesBtn);
        await tester.tap(openGamesBtn);
        await tester.pumpAndSettle();

        // Verify on ChristmasMiniGamesScreen
        expect(
          find.text(AppStrings.miniGamesScreenTitle),
          findsAtLeastNWidgets(1),
        );

        // Tap back
        final backBtn = find.byType(BackButton);
        expect(backBtn, findsOneWidget);
        await tester.tap(backBtn);
        await tester.pumpAndSettle();

        // Verify back on HomeScreen
        expect(find.byKey(const Key('btn_open_mini_games')), findsOneWidget);
      },
    );

    testWidgets(
      'navigates to AdventStorybookScreen and returns to HomeScreen',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTestableWidget());
        await tester.pumpAndSettle();

        // Tap "Đọc Cuốn Sách"
        final openAdventBtn = find.byKey(const Key('btn_open_advent'));
        expect(openAdventBtn, findsOneWidget);
        await tester.ensureVisible(openAdventBtn);
        await tester.tap(openAdventBtn);
        await tester.pumpAndSettle();

        // Verify on AdventStorybookScreen
        expect(
          find.text(AppStrings.adventScreenTitle),
          findsAtLeastNWidgets(1),
        );

        // Tap back
        final backBtn = find.byType(BackButton);
        expect(backBtn, findsOneWidget);
        await tester.tap(backBtn);
        await tester.pumpAndSettle();

        // Verify back on HomeScreen
        expect(find.byKey(const Key('btn_open_advent')), findsOneWidget);
      },
    );

    testWidgets('navigates to WelcomeScreen and returns to HomeScreen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      // Tap About button
      final aboutBtn = find.widgetWithText(
        ElevatedButton,
        AppStrings.aboutAppButton,
      );
      await tester.ensureVisible(aboutBtn);
      await tester.tap(aboutBtn);
      await tester.pumpAndSettle();

      // Verify on WelcomeScreen
      expect(find.text(AppStrings.welcomeTitle), findsOneWidget);

      // Tap "Vào Trang Chủ" to return
      final enterHomeBtn = find.text(AppStrings.enterHomeButton);
      await tester.ensureVisible(enterHomeBtn);
      await tester.tap(enterHomeBtn);
      await tester.pumpAndSettle();

      // Verify back on HomeScreen
      expect(find.text(AppStrings.countdownPreviewTitle), findsOneWidget);
    });

    testWidgets('renders without overflow on small screens (360x640)', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.appName), findsAtLeastNWidgets(1));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders without overflow on standard screens (390x844)', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.appName), findsAtLeastNWidgets(1));
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders without overflow on tablet screens (768x1024)', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(768, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.appName), findsAtLeastNWidgets(1));
      expect(tester.takeException(), isNull);
    });
  });
}
