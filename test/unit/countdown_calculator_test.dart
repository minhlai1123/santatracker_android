import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/core/constants/app_strings.dart';
import 'package:chrimastsatastracker/features/countdown/domain/models/countdown_message_type.dart';
import 'package:chrimastsatastracker/features/countdown/domain/services/countdown_calculator.dart';

void main() {
  group('CountdownCalculator Unit Tests', () {
    test('1. Ngày trước Giáng Sinh nhiều tháng (Tháng 3, Tháng 10)', () {
      final nowMarch = DateTime(2026, 3, 15, 10, 0, 0);
      final stateMarch = CountdownCalculator.calculate(nowMarch);

      expect(stateMarch.target, equals(DateTime(2026, 12, 25, 0, 0, 0)));
      expect(stateMarch.days, greaterThan(30));
      expect(stateMarch.isChristmasDay, isFalse);
      expect(
        stateMarch.messageType,
        equals(CountdownMessageType.overThirtyDays),
      );
      expect(stateMarch.message, equals(AppStrings.messageOverThirtyDays));

      final nowOctober = DateTime(2026, 10, 12, 12, 0, 0);
      final stateOctober = CountdownCalculator.calculate(nowOctober);
      expect(stateOctober.target, equals(DateTime(2026, 12, 25, 0, 0, 0)));
      expect(stateOctober.days, greaterThan(30));
      expect(
        stateOctober.messageType,
        equals(CountdownMessageType.overThirtyDays),
      );
    });

    test('2. Ngày trước Giáng Sinh một ngày (00:00:00 ngày 24/12)', () {
      final now = DateTime(2026, 12, 24, 0, 0, 0);
      final state = CountdownCalculator.calculate(now);

      expect(state.target, equals(DateTime(2026, 12, 25, 0, 0, 0)));
      expect(state.days, equals(1));
      expect(state.hours, equals(0));
      expect(state.minutes, equals(0));
      expect(state.seconds, equals(0));
      expect(state.isChristmasDay, isFalse);
      expect(state.messageType, equals(CountdownMessageType.oneToSevenDays));
      expect(state.message, equals(AppStrings.messageOneToSevenDays));
    });

    test('3. Ngay trước 00:00:00 ngày 25/12 (23:59:59 ngày 24/12)', () {
      final now = DateTime(2026, 12, 24, 23, 59, 59);
      final state = CountdownCalculator.calculate(now);

      expect(state.target, equals(DateTime(2026, 12, 25, 0, 0, 0)));
      expect(state.days, equals(0));
      expect(state.hours, equals(0));
      expect(state.minutes, equals(0));
      expect(state.seconds, equals(1));
      expect(state.isChristmasDay, isFalse);
      expect(state.messageType, equals(CountdownMessageType.under24Hours));
      expect(state.message, equals(AppStrings.messageUnder24Hours));
    });

    test('4. Đúng 00:00:00 ngày 25/12', () {
      final now = DateTime(2026, 12, 25, 0, 0, 0);
      final state = CountdownCalculator.calculate(now);

      expect(state.target, equals(DateTime(2027, 12, 25, 0, 0, 0)));
      expect(state.isChristmasDay, isTrue);
      expect(state.messageType, equals(CountdownMessageType.christmasDay));
      expect(state.message, equals(AppStrings.messageChristmasDay));
      expect(state.days, equals(365));
      expect(state.hours, equals(0));
      expect(state.minutes, equals(0));
      expect(state.seconds, equals(0));
    });

    test('5. Sau 00:00:00 ngày 25/12 (00:00:01 ngày 25/12)', () {
      final now = DateTime(2026, 12, 25, 0, 0, 1);
      final state = CountdownCalculator.calculate(now);

      expect(state.target, equals(DateTime(2027, 12, 25, 0, 0, 0)));
      expect(state.isChristmasDay, isTrue);
      expect(state.messageType, equals(CountdownMessageType.christmasDay));
      expect(state.message, equals(AppStrings.messageChristmasDay));
      expect(state.days, equals(364));
      expect(state.hours, equals(23));
      expect(state.minutes, equals(59));
      expect(state.seconds, equals(59));
    });

    test('6. Ngày 25/12 vào buổi trưa (12:00:00 ngày 25/12)', () {
      final now = DateTime(2026, 12, 25, 12, 0, 0);
      final state = CountdownCalculator.calculate(now);

      expect(state.target, equals(DateTime(2027, 12, 25, 0, 0, 0)));
      expect(state.isChristmasDay, isTrue);
      expect(state.messageType, equals(CountdownMessageType.christmasDay));
      expect(state.days, equals(364));
      expect(state.hours, equals(12));
      expect(state.minutes, equals(0));
      expect(state.seconds, equals(0));
    });

    test('7. Ngày 26/12', () {
      final now = DateTime(2026, 12, 26, 0, 0, 0);
      final state = CountdownCalculator.calculate(now);

      expect(state.target, equals(DateTime(2027, 12, 25, 0, 0, 0)));
      expect(state.isChristmasDay, isFalse);
      expect(state.days, equals(364));
      expect(state.messageType, equals(CountdownMessageType.overThirtyDays));
    });

    test('8. Ngày 31/12', () {
      final now = DateTime(2026, 12, 31, 23, 59, 59);
      final state = CountdownCalculator.calculate(now);

      expect(state.target, equals(DateTime(2027, 12, 25, 0, 0, 0)));
      expect(state.isChristmasDay, isFalse);
      expect(state.days, equals(358));
      expect(state.hours, equals(0));
      expect(state.minutes, equals(0));
      expect(state.seconds, equals(1));
      expect(state.messageType, equals(CountdownMessageType.overThirtyDays));
    });

    test('9. Ngày 01/01 năm tiếp theo', () {
      final now = DateTime(2027, 1, 1, 0, 0, 0);
      final state = CountdownCalculator.calculate(now);

      expect(state.target, equals(DateTime(2027, 12, 25, 0, 0, 0)));
      expect(state.isChristmasDay, isFalse);
      expect(state.days, equals(358));
      expect(state.hours, equals(0));
      expect(state.minutes, equals(0));
      expect(state.seconds, equals(0));
      expect(state.messageType, equals(CountdownMessageType.overThirtyDays));
    });

    test('10. Năm nhuận (2024) và năm không nhuận (2025/2026)', () {
      // 2024 là năm nhuận: tháng 2 có 29 ngày
      final leapYearNow = DateTime(2023, 12, 25, 0, 0, 0);
      final leapState = CountdownCalculator.calculate(leapYearNow);
      expect(leapState.target, equals(DateTime(2024, 12, 25, 0, 0, 0)));
      expect(leapState.days, equals(366)); // 366 ngày vì 2024 có 29/2

      // 2025 là năm thường: tháng 2 có 28 ngày
      final nonLeapYearNow = DateTime(2024, 12, 25, 0, 0, 0);
      final nonLeapState = CountdownCalculator.calculate(nonLeapYearNow);
      expect(nonLeapState.target, equals(DateTime(2025, 12, 25, 0, 0, 0)));
      expect(nonLeapState.days, equals(365));
    });

    test('11. Số ngày còn lại bằng 0 khi còn dưới 24 giờ', () {
      final now = DateTime(2026, 12, 24, 15, 30, 0);
      final state = CountdownCalculator.calculate(now);

      expect(state.days, equals(0));
      expect(state.hours, equals(8));
      expect(state.minutes, equals(30));
      expect(state.seconds, equals(0));
      expect(state.messageType, equals(CountdownMessageType.under24Hours));
    });

    test('12. Không xuất hiện giá trị âm trên toàn bộ các mốc', () {
      final testDates = [
        DateTime(2026, 1, 1),
        DateTime(2026, 12, 24, 23, 59, 59),
        DateTime(2026, 12, 25, 0, 0, 0),
        DateTime(2026, 12, 25, 23, 59, 59),
        DateTime(2026, 12, 26, 0, 0, 0),
      ];

      for (final date in testDates) {
        final state = CountdownCalculator.calculate(date);
        expect(state.days, greaterThanOrEqualTo(0));
        expect(state.hours, inInclusiveRange(0, 23));
        expect(state.minutes, inInclusiveRange(0, 59));
        expect(state.seconds, inInclusiveRange(0, 59));
      }
    });

    test('13. Phép tính ngày, giờ, phút, giây chính xác ở các ranh giới', () {
      // Đúng 1 giờ trước Giáng Sinh
      final oneHourBefore = DateTime(2026, 12, 24, 23, 0, 0);
      final stateOneHour = CountdownCalculator.calculate(oneHourBefore);
      expect(stateOneHour.days, equals(0));
      expect(stateOneHour.hours, equals(1));
      expect(stateOneHour.minutes, equals(0));
      expect(stateOneHour.seconds, equals(0));

      // Đúng 1 phút trước Giáng Sinh
      final oneMinBefore = DateTime(2026, 12, 24, 23, 59, 0);
      final stateOneMin = CountdownCalculator.calculate(oneMinBefore);
      expect(stateOneMin.days, equals(0));
      expect(stateOneMin.hours, equals(0));
      expect(stateOneMin.minutes, equals(1));
      expect(stateOneMin.seconds, equals(0));

      // Đúng 1 giây trước Giáng Sinh
      final oneSecBefore = DateTime(2026, 12, 24, 23, 59, 59);
      final stateOneSec = CountdownCalculator.calculate(oneSecBefore);
      expect(stateOneSec.days, equals(0));
      expect(stateOneSec.hours, equals(0));
      expect(stateOneSec.minutes, equals(0));
      expect(stateOneSec.seconds, equals(1));
    });

    test('14. Thông điệp thay đổi đúng theo các ngưỡng thời gian', () {
      // > 30 ngày: 15/11/2026
      final over30Days = DateTime(2026, 11, 15, 0, 0, 0);
      expect(
        CountdownCalculator.calculate(over30Days).messageType,
        equals(CountdownMessageType.overThirtyDays),
      );

      // 8 đến 30 ngày: 10/12/2026
      final eightTo30Days = DateTime(2026, 12, 10, 0, 0, 0);
      expect(
        CountdownCalculator.calculate(eightTo30Days).messageType,
        equals(CountdownMessageType.eightToThirtyDays),
      );

      // 1 đến 7 ngày: 20/12/2026
      final oneTo7Days = DateTime(2026, 12, 20, 0, 0, 0);
      expect(
        CountdownCalculator.calculate(oneTo7Days).messageType,
        equals(CountdownMessageType.oneToSevenDays),
      );

      // < 24 giờ: 24/12/2026 lúc 18:00
      final under24H = DateTime(2026, 12, 24, 18, 0, 0);
      expect(
        CountdownCalculator.calculate(under24H).messageType,
        equals(CountdownMessageType.under24Hours),
      );

      // Đúng ngày 25/12
      final christmas = DateTime(2026, 12, 25, 8, 0, 0);
      expect(
        CountdownCalculator.calculate(christmas).messageType,
        equals(CountdownMessageType.christmasDay),
      );
    });

    test('15. Thời điểm mục tiêu chuyển sang năm sau đúng quy tắc', () {
      final beforeMidnight = DateTime(2026, 12, 24, 23, 59, 59);
      expect(
        CountdownCalculator.getNextChristmasTarget(beforeMidnight),
        equals(DateTime(2026, 12, 25, 0, 0, 0)),
      );

      final atMidnight = DateTime(2026, 12, 25, 0, 0, 0);
      expect(
        CountdownCalculator.getNextChristmasTarget(atMidnight),
        equals(DateTime(2027, 12, 25, 0, 0, 0)),
      );
    });

    test(
      '16. Trạng thái ngày lễ và mục tiêu countdown độc lập, không mâu thuẫn',
      () {
        final christmasNoon = DateTime(2026, 12, 25, 12, 0, 0);
        final state = CountdownCalculator.calculate(christmasNoon);

        // Hiển thị lời chúc ngày 25/12
        expect(state.isChristmasDay, isTrue);
        expect(state.message, equals(AppStrings.messageChristmasDay));

        // Trong khi countdown vẫn hướng đến Giáng Sinh năm tiếp theo (2027)
        expect(state.target.year, equals(2027));
        expect(state.days, equals(364));
      },
    );
  });
}
