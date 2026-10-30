import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/app/app.dart';
import 'package:chrimastsatastracker/core/constants/app_strings.dart';
import 'package:chrimastsatastracker/features/welcome/presentation/screens/welcome_screen.dart';

void main() {
  testWidgets('App initializes correctly and renders HomeScreen by default', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChrimastsatastrackerApp(clock: () => DateTime(2026, 12, 1, 10, 0, 0)),
    );
    await tester.pumpAndSettle();

    // Verify application title is rendered
    expect(find.text(AppStrings.appName), findsAtLeastNWidgets(1));

    // Verify festive tagline is rendered
    expect(find.text(AppStrings.festiveTagline), findsOneWidget);

    // Verify countdown preview is present
    expect(find.text(AppStrings.countdownPreviewTitle), findsOneWidget);
    expect(find.text(AppStrings.openCountdownButton), findsOneWidget);
  });

  testWidgets('App preserves WelcomeScreen when rendered explicitly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const ChrimastsatastrackerApp(home: WelcomeScreen()),
    );
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.appName), findsOneWidget);
    expect(find.text(AppStrings.welcomeTitle), findsOneWidget);
    expect(find.text(AppStrings.foundationStatusTitle), findsOneWidget);
  });
}
