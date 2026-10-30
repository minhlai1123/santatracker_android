import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chrimastsatastracker/features/notifications/data/notification_preferences_storage.dart';
import 'package:chrimastsatastracker/features/notifications/domain/models/notification_settings.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NotificationPreferencesStorage Tests', () {
    late NotificationPreferencesStorage storage;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      storage = NotificationPreferencesStorage();
    });

    test('Loads default settings when no preferences stored', () async {
      final settings = await storage.getSettings();
      expect(settings.isEnabled, isTrue);
      expect(settings.preferredHour, equals(9));
      expect(settings.preferredMinute, equals(0));
      expect(settings.evenDaysSpecialEnabled, isTrue);
      expect(settings.lastNotifiedDate, isNull);
    });

    test('Saves and retrieves updated notification settings', () async {
      const newSettings = NotificationSettings(
        isEnabled: false,
        preferredHour: 20,
        preferredMinute: 30,
        evenDaysSpecialEnabled: true,
        lastNotifiedDate: '2026-10-20',
      );

      await storage.saveSettings(newSettings);
      final retrieved = await storage.getSettings();

      expect(retrieved.isEnabled, isFalse);
      expect(retrieved.preferredHour, equals(20));
      expect(retrieved.preferredMinute, equals(30));
      expect(retrieved.evenDaysSpecialEnabled, isTrue);
      expect(retrieved.lastNotifiedDate, equals('2026-10-20'));
    });

    test(
      'Records notification date and detects hasNotifiedToday accurately',
      () async {
        final today = DateTime(2026, 10, 20);
        final tomorrow = DateTime(2026, 10, 21);

        expect(await storage.hasNotifiedToday(today), isFalse);

        await storage.recordNotificationSent(today);

        expect(await storage.hasNotifiedToday(today), isTrue);
        expect(await storage.hasNotifiedToday(tomorrow), isFalse);
      },
    );
  });
}
