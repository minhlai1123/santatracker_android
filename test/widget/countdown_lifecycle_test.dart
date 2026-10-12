import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/core/constants/app_strings.dart';
import 'package:chrimastsatastracker/core/theme/app_theme.dart';
import 'package:chrimastsatastracker/features/countdown/presentation/screens/countdown_screen.dart';

void main() {
  group('CountdownScreen Lifecycle Tests', () {
    testWidgets('timer advances and updates display smoothly', (
      WidgetTester tester,
    ) async {
      var currentTime = DateTime(2026, 12, 24, 23, 59, 57);
      DateTime getClock() => currentTime;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: CountdownScreen(clock: getClock),
        ),
      );
      await tester.pump();

      // Initial: 3 seconds remaining
      expect(find.text('03'), findsOneWidget);

      // Advance clock by 1 second and pump timer
      currentTime = currentTime.add(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('02'), findsOneWidget);

      // Advance clock by another second
      currentTime = currentTime.add(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('01'), findsOneWidget);

      // Advance clock to Christmas midnight (00:00:00 ngày 25/12)
      currentTime = currentTime.add(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));

      // Target switches to 2027 and celebration greeting appears
      expect(find.text(AppStrings.christmasDayBadge), findsOneWidget);
      expect(find.text(AppStrings.messageChristmasDay), findsOneWidget);
    });

    testWidgets('disposes cleanly without throwing exceptions', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(theme: AppTheme.lightTheme, home: const CountdownScreen()),
      );
      await tester.pump();

      // Replace with another widget to trigger dispose
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: Text('Disposed'))),
      );
      await tester.pump();

      expect(tester.takeException(), isNull);
    });

    testWidgets('handles app lifecycle resume event', (
      WidgetTester tester,
    ) async {
      var currentTime = DateTime(2026, 12, 20, 10, 0, 0);
      DateTime getClock() => currentTime;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: CountdownScreen(clock: getClock),
        ),
      );
      await tester.pump();

      // Simulate jumping 1 day forward during app background
      currentTime = DateTime(2026, 12, 21, 10, 0, 0);

      // Trigger lifecycle resumed state
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();

      // Verify days updated from 4 to 3
      expect(find.text('3'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
