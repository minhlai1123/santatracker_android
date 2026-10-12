import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/core/constants/app_strings.dart';
import 'package:chrimastsatastracker/core/theme/app_theme.dart';
import 'package:chrimastsatastracker/features/welcome/presentation/screens/welcome_screen.dart';

void main() {
  Widget buildTestableWidget() {
    return MaterialApp(theme: AppTheme.lightTheme, home: const WelcomeScreen());
  }

  group('WelcomeScreen Tests', () {
    testWidgets('renders all essential elements and badges', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      // App Name
      expect(find.text(AppStrings.appName), findsOneWidget);

      // Intro content
      expect(find.text(AppStrings.welcomeTitle), findsOneWidget);
      expect(find.text(AppStrings.welcomeSubtitle), findsOneWidget);

      // Foundation status
      expect(find.text(AppStrings.foundationStatusTitle), findsOneWidget);
      expect(find.text(AppStrings.foundationStatusDesc), findsOneWidget);

      // Badges
      expect(find.text(AppStrings.offlineFirstBadge), findsOneWidget);
      expect(find.text(AppStrings.privacyBadge), findsOneWidget);

      // Holiday greeting
      expect(find.text(AppStrings.holidayGreeting), findsOneWidget);

      // Icons
      expect(find.byIcon(Icons.star_rounded), findsOneWidget);
      expect(find.byIcon(Icons.verified_rounded), findsOneWidget);
      expect(find.byIcon(Icons.cloud_off_rounded), findsOneWidget);
      expect(find.byIcon(Icons.shield_rounded), findsOneWidget);
    });

    testWidgets(
      'renders correctly without overflow on small screens (360x640)',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(360, 640);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(buildTestableWidget());
        await tester.pumpAndSettle();

        expect(find.text(AppStrings.appName), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      'renders correctly without overflow on standard screens (390x844)',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(buildTestableWidget());
        await tester.pumpAndSettle();

        expect(find.text(AppStrings.appName), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets('renders correctly on tablet screens (768x1024)', (
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

      expect(find.text(AppStrings.appName), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
