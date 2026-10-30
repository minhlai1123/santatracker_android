import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/core/constants/app_strings.dart';
import 'package:chrimastsatastracker/core/theme/app_theme.dart';
import 'package:chrimastsatastracker/features/countdown/presentation/widgets/home_screen_widget_card.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('HomeScreenWidgetCard Widget Tests', () {
    testWidgets(
      'renders widget section title, preview, guide and sync button',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.lightTheme,
            home: Scaffold(
              body: SingleChildScrollView(
                child: HomeScreenWidgetCard(
                  clock: () => DateTime(2026, 10, 20, 10, 0, 0),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Section title & subtitle
        expect(find.text(AppStrings.widgetSectionTitle), findsOneWidget);
        expect(find.text(AppStrings.widgetSectionSubtitle), findsOneWidget);

        // Mini widget preview
        expect(find.text('66'), findsOneWidget);
        expect(find.text('DAYS UNTIL CHRISTMAS'), findsOneWidget);
        expect(find.text('✨ Even-Day Special Active'), findsOneWidget);

        // How to add guide
        expect(find.text(AppStrings.widgetHowToAddAndroid), findsOneWidget);
        expect(find.text(AppStrings.widgetHowToAddIos), findsOneWidget);

        // Sync button
        final syncBtn = find.byKey(const Key('btn_sync_widget'));
        expect(syncBtn, findsOneWidget);
        expect(find.text(AppStrings.syncWidgetButton), findsOneWidget);

        // Tap sync button and verify feedback toast
        await tester.tap(syncBtn);
        await tester.pumpAndSettle();

        expect(find.text(AppStrings.widgetSyncedToast), findsOneWidget);
      },
    );
  });
}
