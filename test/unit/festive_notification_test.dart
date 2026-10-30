import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/features/notifications/domain/services/festive_notification_catalog.dart';

void main() {
  group('FestiveNotificationCatalog Tests', () {
    test('isEvenDay correctly identifies even calendar days', () {
      expect(
        FestiveNotificationCatalog.isEvenDay(DateTime(2026, 10, 2)),
        isTrue,
      );
      expect(
        FestiveNotificationCatalog.isEvenDay(DateTime(2026, 10, 4)),
        isTrue,
      );
      expect(
        FestiveNotificationCatalog.isEvenDay(DateTime(2026, 10, 20)),
        isTrue,
      );
      expect(
        FestiveNotificationCatalog.isEvenDay(DateTime(2026, 12, 24)),
        isTrue,
      );
    });

    test('isEvenDay correctly identifies odd calendar days', () {
      expect(
        FestiveNotificationCatalog.isEvenDay(DateTime(2026, 10, 1)),
        isFalse,
      );
      expect(
        FestiveNotificationCatalog.isEvenDay(DateTime(2026, 10, 3)),
        isFalse,
      );
      expect(
        FestiveNotificationCatalog.isEvenDay(DateTime(2026, 10, 21)),
        isFalse,
      );
      expect(
        FestiveNotificationCatalog.isEvenDay(DateTime(2026, 12, 25)),
        isFalse,
      );
    });

    test(
      'All December even days have isEvenDaySpecial = true and valid content',
      () {
        final evenDays = [
          2,
          4,
          6,
          8,
          10,
          12,
          14,
          16,
          18,
          20,
          22,
          24,
          26,
          28,
          30,
        ];
        for (final day in evenDays) {
          final notif = FestiveNotificationCatalog.getNotificationForDate(
            DateTime(2026, 12, day),
          );
          expect(
            notif.isEvenDaySpecial,
            isTrue,
            reason: 'Day $day should be even-day special',
          );
          expect(notif.day, equals(day));
          expect(notif.title, isNotEmpty);
          expect(notif.body, isNotEmpty);
          expect(
            notif.title.contains('Special') ||
                notif.title.contains('Christmas Eve'),
            isTrue,
          );
        }
      },
    );

    test(
      'All December odd days have isEvenDaySpecial = false and valid content',
      () {
        final oddDays = [
          1,
          3,
          5,
          7,
          9,
          11,
          13,
          15,
          17,
          19,
          21,
          23,
          25,
          27,
          29,
          31,
        ];
        for (final day in oddDays) {
          final notif = FestiveNotificationCatalog.getNotificationForDate(
            DateTime(2026, 12, day),
          );
          expect(
            notif.isEvenDaySpecial,
            isFalse,
            reason: 'Day $day should be regular cheer',
          );
          expect(notif.day, equals(day));
          expect(notif.title, isNotEmpty);
          expect(notif.body, isNotEmpty);
        }
      },
    );

    test(
      'Even days in other months (e.g. October 20) generate even-day special',
      () {
        final notif = FestiveNotificationCatalog.getNotificationForDate(
          DateTime(2026, 10, 20),
        );
        expect(notif.isEvenDaySpecial, isTrue);
        expect(notif.title, contains('[Even-Day Special]'));
        expect(notif.body, contains('until Christmas'));
      },
    );

    test('Odd days in other months (e.g. October 21) generate daily countdown cheer', () {
      final notif = FestiveNotificationCatalog.getNotificationForDate(
        DateTime(2026, 10, 21),
      );
      expect(notif.isEvenDaySpecial, isFalse);
      expect(notif.title, contains('Christmas Countdown'));
      expect(notif.body, contains('until Christmas'));
    });

    test('daysUntilChristmas calculates remaining days accurately', () {
      final daysFromOct20 = FestiveNotificationCatalog.daysUntilChristmas(
        DateTime(2026, 10, 20),
      );
      expect(daysFromOct20, equals(66));

      final daysFromDec24 = FestiveNotificationCatalog.daysUntilChristmas(
        DateTime(2026, 12, 24),
      );
      expect(daysFromDec24, equals(1));

      final daysFromDec25 = FestiveNotificationCatalog.daysUntilChristmas(
        DateTime(2026, 12, 25),
      );
      expect(daysFromDec25, equals(0));
    });
  });
}
