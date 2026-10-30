import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/core/services/christmas_widget_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ChristmasWidgetService Tests', () {
    test(
      'getWidgetData on Christmas Day returns 0 days and celebration label',
      () {
        final data = ChristmasWidgetService.getWidgetData(
          date: DateTime(2026, 12, 25, 10, 0, 0),
        );
        expect(data.daysLeft, equals(0));
        expect(data.daysLabel, equals('TODAY IS CHRISTMAS!'));
      },
    );

    test(
      'getWidgetData on Christmas Eve returns 1 day and even-day special badge',
      () {
        final data = ChristmasWidgetService.getWidgetData(
          date: DateTime(2026, 12, 24, 18, 0, 0),
        );
        expect(data.daysLeft, equals(1));
        expect(data.isEvenDay, isTrue);
        expect(data.daysLabel, equals('DAY UNTIL CHRISTMAS'));
        expect(data.statusBadge, contains('Even-Day Special'));
      },
    );

    test('getWidgetData on even calendar day sets isEvenDay = true', () {
      final data = ChristmasWidgetService.getWidgetData(
        date: DateTime(2026, 10, 20),
      );
      expect(data.isEvenDay, isTrue);
      expect(data.daysLeft, equals(66));
      expect(data.daysLabel, equals('DAYS UNTIL CHRISTMAS'));
      expect(data.statusBadge, contains('Even-Day Special'));
    });

    test('getWidgetData on odd calendar day sets isEvenDay = false', () {
      final data = ChristmasWidgetService.getWidgetData(
        date: DateTime(2026, 10, 21),
      );
      expect(data.isEvenDay, isFalse);
      expect(data.daysLeft, equals(65));
      expect(data.daysLabel, equals('DAYS UNTIL CHRISTMAS'));
      expect(data.statusBadge, contains('Daily Christmas Cheer'));
    });

    test('updateWidget completes without throwing', () async {
      final success = await ChristmasWidgetService.updateWidget();
      expect(success, isTrue);
    });
  });
}
