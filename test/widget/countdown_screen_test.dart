import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/core/constants/app_strings.dart';
import 'package:chrimastsatastracker/core/theme/app_theme.dart';
import 'package:chrimastsatastracker/features/countdown/presentation/screens/countdown_screen.dart';

void main() {
  Widget buildTestableWidget({DateTime Function()? clock}) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: CountdownScreen(
        clock: clock ?? () => DateTime(2026, 12, 20, 10, 0, 0),
      ),
    );
  }

  group('CountdownScreen Widget Tests', () {
    testWidgets('renders all countdown units and target banner', (
      WidgetTester tester,
    ) async {
      DateTime fixedClock() => DateTime(2026, 12, 20, 10, 30, 45);
      await tester.pumpWidget(buildTestableWidget(clock: fixedClock));
      await tester.pumpAndSettle();

      // App bar title
      expect(find.text(AppStrings.countdownScreenTitle), findsOneWidget);

      // Target prefix with year
      expect(
        find.text('${AppStrings.nextChristmasPrefix}2026'),
        findsOneWidget,
      );

      // Time units
      expect(find.text(AppStrings.daysLabel), findsOneWidget);
      expect(find.text(AppStrings.hoursLabel), findsOneWidget);
      expect(find.text(AppStrings.minutesLabel), findsOneWidget);
      expect(find.text(AppStrings.secondsLabel), findsOneWidget);

      // Value check: Dec 20 10:30:45 to Dec 25 00:00:00 is 4 days, 13 hours, 29 mins, 15 secs
      expect(find.text('4'), findsOneWidget);
      expect(find.text('13'), findsOneWidget);
      expect(find.text('29'), findsOneWidget);
      expect(find.text('15'), findsOneWidget);

      // Dynamic message for 1-7 days
      expect(find.text(AppStrings.messageOneToSevenDays), findsOneWidget);

      // Back button
      expect(find.text(AppStrings.backToHomeButton), findsAtLeastNWidgets(1));
    });

    testWidgets('renders Christmas Day celebration UI on 25/12', (
      WidgetTester tester,
    ) async {
      DateTime christmasClock() => DateTime(2026, 12, 25, 10, 0, 0);
      await tester.pumpWidget(buildTestableWidget(clock: christmasClock));
      await tester.pumpAndSettle();

      // Celebration badge
      expect(find.text(AppStrings.christmasDayBadge), findsOneWidget);

      // Christmas Day greeting message
      expect(find.text(AppStrings.messageChristmasDay), findsOneWidget);

      // Target switched to 2027
      expect(
        find.text('${AppStrings.nextChristmasPrefix}2027'),
        findsOneWidget,
      );
    });

    testWidgets('renders under 24 hours message on 24/12 afternoon', (
      WidgetTester tester,
    ) async {
      DateTime under24HClock() => DateTime(2026, 12, 24, 18, 0, 0);
      await tester.pumpWidget(buildTestableWidget(clock: under24HClock));
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.messageUnder24Hours), findsOneWidget);
      expect(find.text('0'), findsOneWidget); // 0 days
      expect(find.text('06'), findsOneWidget); // 6 hours
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

      expect(find.text(AppStrings.countdownScreenTitle), findsOneWidget);
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

      expect(find.text(AppStrings.countdownScreenTitle), findsOneWidget);
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

      expect(find.text(AppStrings.countdownScreenTitle), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
