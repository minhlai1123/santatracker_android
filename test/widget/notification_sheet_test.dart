import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chrimastsatastracker/core/constants/app_strings.dart';
import 'package:chrimastsatastracker/core/theme/app_theme.dart';
import 'package:chrimastsatastracker/features/home/presentation/screens/home_screen.dart';
import 'package:chrimastsatastracker/features/notifications/data/notification_preferences_storage.dart';
import 'package:chrimastsatastracker/features/notifications/presentation/controllers/notification_settings_controller.dart';
import 'package:chrimastsatastracker/features/notifications/presentation/widgets/notification_settings_sheet.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('NotificationSettingsSheet Widget Tests', () {
    testWidgets(
      'Renders all essential sections, even-day callout and buttons',
      (WidgetTester tester) async {
        final storage = NotificationPreferencesStorage();
        final controller = NotificationSettingsController(
          storage: storage,
          clock: () => DateTime(2026, 10, 20, 10, 0, 0),
        );
        await controller.load();

        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.lightTheme,
            home: Scaffold(
              body: NotificationSettingsSheet(controller: controller),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Title & Subtitle
        expect(find.text(AppStrings.dailyRemindersTitle), findsOneWidget);
        expect(find.text(AppStrings.dailyRemindersSubtitle), findsOneWidget);

        // Switch toggle
        expect(
          find.byKey(const Key('key_toggle_daily_notifications')),
          findsOneWidget,
        );
        expect(find.text(AppStrings.enableDailyReminders), findsOneWidget);

        // Even-Day Special callout & badge
        expect(find.text(AppStrings.evenDaysSpecialDesc), findsOneWidget);
        expect(
          find.text(AppStrings.evenDaySpecialBadge.toUpperCase()),
          findsAtLeastNWidgets(1),
        );

        // Test notification button
        expect(
          find.byKey(const Key('btn_send_test_notification')),
          findsOneWidget,
        );
        expect(
          find.text(AppStrings.sendTestNotificationButton),
          findsOneWidget,
        );
      },
    );

    testWidgets('Toggling switch updates settings state', (
      WidgetTester tester,
    ) async {
      final storage = NotificationPreferencesStorage();
      final controller = NotificationSettingsController(
        storage: storage,
        clock: () => DateTime(2026, 10, 20, 10, 0, 0),
      );
      await controller.load();

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: NotificationSettingsSheet(controller: controller),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final switchFinder = find.byKey(
        const Key('key_toggle_daily_notifications'),
      );
      expect(switchFinder, findsOneWidget);

      await tester.tap(switchFinder);
      await tester.pumpAndSettle();

      expect(controller.settings.isEnabled, isFalse);
    });

    testWidgets(
      'HomeScreen has notification button in AppBar that opens settings sheet',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.lightTheme,
            home: HomeScreen(clock: () => DateTime(2026, 10, 20, 10, 0, 0)),
          ),
        );
        await tester.pumpAndSettle();

        final notifBtn = find.byKey(const Key('btn_notifications'));
        expect(notifBtn, findsOneWidget);

        await tester.tap(notifBtn);
        await tester.pumpAndSettle();

        // Verifies the notification sheet is opened
        expect(find.text(AppStrings.dailyRemindersTitle), findsOneWidget);
        expect(
          find.byKey(const Key('btn_send_test_notification')),
          findsOneWidget,
        );
      },
    );
  });
}
