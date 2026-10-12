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

      // Coming soon section
      expect(find.text(AppStrings.comingSoonTitle), findsOneWidget);
      expect(find.text(AppStrings.comingSoonSubtitle), findsOneWidget);
      expect(find.text(AppStrings.trackerFeatureTitle), findsOneWidget);
      expect(find.text(AppStrings.villageFeatureTitle), findsOneWidget);
      expect(find.text(AppStrings.gamesFeatureTitle), findsOneWidget);
      expect(find.text(AppStrings.adventFeatureTitle), findsOneWidget);
      expect(find.text(AppStrings.comingSoonBadge), findsNWidgets(4));

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
