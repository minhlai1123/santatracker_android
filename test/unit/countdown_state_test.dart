import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/features/countdown/domain/models/countdown_message_type.dart';
import 'package:chrimastsatastracker/features/countdown/domain/models/countdown_state.dart';

void main() {
  group('CountdownState Model Tests', () {
    test('formatted getters pad single digit values with 0', () {
      final state = CountdownState(
        days: 5,
        hours: 3,
        minutes: 7,
        seconds: 9,
        target: DateTime(2026, 12, 25),
        isChristmasDay: false,
        message: 'Test message',
        messageType: CountdownMessageType.oneToSevenDays,
      );

      expect(state.formattedDays, equals('5'));
      expect(state.formattedHours, equals('03'));
      expect(state.formattedMinutes, equals('07'));
      expect(state.formattedSeconds, equals('09'));
    });

    test('equality and hashCode work properly', () {
      final state1 = CountdownState(
        days: 10,
        hours: 12,
        minutes: 30,
        seconds: 45,
        target: DateTime(2026, 12, 25),
        isChristmasDay: false,
        message: 'Message',
        messageType: CountdownMessageType.eightToThirtyDays,
      );

      final state2 = CountdownState(
        days: 10,
        hours: 12,
        minutes: 30,
        seconds: 45,
        target: DateTime(2026, 12, 25),
        isChristmasDay: false,
        message: 'Message',
        messageType: CountdownMessageType.eightToThirtyDays,
      );

      expect(state1, equals(state2));
      expect(state1.hashCode, equals(state2.hashCode));
      expect(state1.toString(), contains('CountdownState'));
    });
  });
}
