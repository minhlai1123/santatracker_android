import '../../../../core/constants/app_strings.dart';
import '../models/countdown_message_type.dart';
import '../models/countdown_state.dart';

class CountdownCalculator {
  const CountdownCalculator();

  /// Kiểm tra xem thời điểm đã cho có thuộc đúng ngày Giáng Sinh (25/12) hay không.
  static bool isChristmasDay(DateTime dateTime) {
    return dateTime.month == 12 && dateTime.day == 25;
  }

  /// Xác định mốc Giáng Sinh tiếp theo (00:00:00 ngày 25/12 theo giờ địa phương).
  ///
  /// - Nếu thời điểm hiện tại trước 00:00:00 ngày 25/12 của năm hiện tại,
  ///   mục tiêu là ngày 25/12 của năm hiện tại.
  /// - Nếu thời điểm hiện tại đúng hoặc sau 00:00:00 ngày 25/12,
  ///   mục tiêu là ngày 25/12 của năm tiếp theo.
  static DateTime getNextChristmasTarget(DateTime now) {
    final currentYearTarget = DateTime(now.year, 12, 25, 0, 0, 0);
    if (now.isBefore(currentYearTarget)) {
      return currentYearTarget;
    } else {
      return DateTime(now.year + 1, 12, 25, 0, 0, 0);
    }
  }

  /// Xác định loại thông điệp tương ứng dựa trên trạng thái ngày lễ và khoảng thời gian còn lại.
  static CountdownMessageType getMessageType({
    required bool isChristmas,
    required Duration remainingDuration,
  }) {
    if (isChristmas) {
      return CountdownMessageType.christmasDay;
    }

    final days = remainingDuration.inDays;
    final totalHours = remainingDuration.inHours;

    if (totalHours < 24) {
      return CountdownMessageType.under24Hours;
    } else if (days >= 1 && days <= 7) {
      return CountdownMessageType.oneToSevenDays;
    } else if (days >= 8 && days <= 30) {
      return CountdownMessageType.eightToThirtyDays;
    } else {
      return CountdownMessageType.overThirtyDays;
    }
  }

  /// Lấy chuỗi thông điệp tiếng Việt tương ứng với loại thông điệp.
  static String getMessageForType(CountdownMessageType type) {
    switch (type) {
      case CountdownMessageType.christmasDay:
        return AppStrings.messageChristmasDay;
      case CountdownMessageType.under24Hours:
        return AppStrings.messageUnder24Hours;
      case CountdownMessageType.oneToSevenDays:
        return AppStrings.messageOneToSevenDays;
      case CountdownMessageType.eightToThirtyDays:
        return AppStrings.messageEightToThirtyDays;
      case CountdownMessageType.overThirtyDays:
        return AppStrings.messageOverThirtyDays;
    }
  }

  /// Tính toán toàn bộ trạng thái đếm ngược cho một thời điểm cụ thể.
  /// Hàm thuần túy (pure function), dễ dàng kiểm thử độc lập mà không cần chờ thời gian thật.
  static CountdownState calculate(DateTime now) {
    final isChristmas = isChristmasDay(now);
    final target = getNextChristmasTarget(now);
    var duration = target.difference(now);

    if (duration.isNegative) {
      duration = Duration.zero;
    }

    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    final messageType = getMessageType(
      isChristmas: isChristmas,
      remainingDuration: duration,
    );

    return CountdownState(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      target: target,
      isChristmasDay: isChristmas,
      message: getMessageForType(messageType),
      messageType: messageType,
    );
  }
}
