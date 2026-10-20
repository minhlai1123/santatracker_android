import '../../../../core/constants/app_strings.dart';
import '../models/countdown_message_type.dart';
import '../models/countdown_state.dart';

class CountdownCalculator {
  const CountdownCalculator();

  /// Checks if the given date is Christmas Day (December 25th).
  static bool isChristmasDay(DateTime dateTime) {
    return dateTime.month == 12 && dateTime.day == 25;
  }

  /// Determines the next Christmas target (00:00:00 on Dec 25th in local time).
  ///
  /// - If current time is before 00:00:00 on Dec 25th of the current year,
  ///   the target is Dec 25th of the current year.
  /// - If current time is on or after 00:00:00 on Dec 25th,
  ///   the target is Dec 25th of the next year.
  static DateTime getNextChristmasTarget(DateTime now) {
    final currentYearTarget = DateTime(now.year, 12, 25, 0, 0, 0);
    if (now.isBefore(currentYearTarget)) {
      return currentYearTarget;
    } else {
      return DateTime(now.year + 1, 12, 25, 0, 0, 0);
    }
  }

  /// Determines the message type based on holiday status and remaining duration.
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

  /// Retrieves the message string corresponding to the message type.
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

  /// Calculates the full countdown state for a given moment in time.
  /// Pure function for reliable unit testing without requiring real-time delays.
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
