import 'countdown_message_type.dart';

class CountdownState {
  final int days;
  final int hours;
  final int minutes;
  final int seconds;
  final DateTime target;
  final bool isChristmasDay;
  final String message;
  final CountdownMessageType messageType;

  const CountdownState({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.target,
    required this.isChristmasDay,
    required this.message,
    required this.messageType,
  });

  String get formattedDays => '$days';
  String get formattedHours => hours.toString().padLeft(2, '0');
  String get formattedMinutes => minutes.toString().padLeft(2, '0');
  String get formattedSeconds => seconds.toString().padLeft(2, '0');

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CountdownState &&
        other.days == days &&
        other.hours == hours &&
        other.minutes == minutes &&
        other.seconds == seconds &&
        other.target == target &&
        other.isChristmasDay == isChristmasDay &&
        other.message == message &&
        other.messageType == messageType;
  }

  @override
  int get hashCode => Object.hash(
    days,
    hours,
    minutes,
    seconds,
    target,
    isChristmasDay,
    message,
    messageType,
  );

  @override
  String toString() {
    return 'CountdownState(days: $days, hours: $hours, minutes: $minutes, seconds: $seconds, '
        'target: $target, isChristmasDay: $isChristmasDay, messageType: $messageType)';
  }
}
