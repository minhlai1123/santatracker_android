import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/app/app.dart';
import 'package:chrimastsatastracker/core/constants/app_strings.dart';

void main() {
  testWidgets('App initializes correctly and renders WelcomeScreen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ChrimastsatastrackerApp());
    await tester.pumpAndSettle();

    // Verify application title is rendered
    expect(find.text(AppStrings.appName), findsOneWidget);

    // Verify welcome message and tagline are rendered
    expect(find.text(AppStrings.welcomeTitle), findsOneWidget);
    expect(find.text(AppStrings.welcomeSubtitle), findsOneWidget);
    expect(find.text(AppStrings.festiveTagline), findsOneWidget);

    // Verify foundation status card
    expect(find.text(AppStrings.foundationStatusTitle), findsOneWidget);
  });
}
