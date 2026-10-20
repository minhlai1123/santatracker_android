import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chrimastsatastracker/features/notifications/data/notification_preferences_storage.dart';
import 'package:chrimastsatastracker/features/notifications/presentation/controllers/notification_settings_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NotificationSettingsController Tests', () {
    late NotificationPreferencesStorage storage;
    late NotificationSettingsController controller;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      storage = NotificationPreferencesStorage();
      controller = NotificationSettingsController(
        storage: storage,
        clock: () => DateTime(2026, 10, 20, 10, 0, 0),
      );
    });

    test(
      'Initializes with default settings and correct today notification',
      () async {
        await controller.load();
        expect(controller.isLoading, isFalse);
        expect(controller.settings.isEnabled, isTrue);
        expect(controller.isTodayEvenDay, isTrue);
        expect(controller.todayNotification.isEvenDaySpecial, isTrue);
        expect(controller.todayNotification.day, equals(20));
      },
    );

    test('Toggles reminder enabled state and persists change', () async {
      await controller.load();
      await controller.toggleEnabled(false);

      expect(controller.settings.isEnabled, isFalse);
      final saved = await storage.getSettings();
      expect(saved.isEnabled, isFalse);

      await controller.toggleEnabled(true);
      expect(controller.settings.isEnabled, isTrue);
      final saved2 = await storage.getSettings();
      expect(saved2.isEnabled, isTrue);
    });

    test('Updates reminder time and persists change', () async {
      await controller.load();
      await controller.updateTime(20, 15);

      expect(controller.settings.preferredHour, equals(20));
      expect(controller.settings.preferredMinute, equals(15));

      final saved = await storage.getSettings();
      expect(saved.preferredHour, equals(20));
      expect(saved.preferredMinute, equals(15));
    });

    test('Sends test notification and marks today as notified', () async {
      await controller.load();
      final item = await controller.sendTestNotification();

      expect(item.day, equals(20));
      expect(item.isEvenDaySpecial, isTrue);
      expect(await storage.hasNotifiedToday(DateTime(2026, 10, 20)), isTrue);
    });
  });
}
