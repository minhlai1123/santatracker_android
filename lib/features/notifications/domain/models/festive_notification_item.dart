class FestiveNotificationItem {
  final String id;
  final String title;
  final String body;
  final bool isEvenDaySpecial;
  final int day;
  final String? payload;
  final DateTime? scheduledDate;

  const FestiveNotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.isEvenDaySpecial,
    required this.day,
    this.payload,
    this.scheduledDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'isEvenDaySpecial': isEvenDaySpecial,
      'day': day,
      'payload': payload,
      'scheduledDate': scheduledDate?.toIso8601String(),
    };
  }

  factory FestiveNotificationItem.fromMap(Map<String, dynamic> map) {
    return FestiveNotificationItem(
      id: map['id'] as String? ?? 'notif_default',
      title: map['title'] as String? ?? 'Christmas Cheer',
      body: map['body'] as String? ?? 'Merry Christmas!',
      isEvenDaySpecial: map['isEvenDaySpecial'] as bool? ?? false,
      day: map['day'] as int? ?? 1,
      payload: map['payload'] as String?,
      scheduledDate: map['scheduledDate'] != null
          ? DateTime.tryParse(map['scheduledDate'] as String)
          : null,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FestiveNotificationItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          body == other.body &&
          isEvenDaySpecial == other.isEvenDaySpecial &&
          day == other.day;

  @override
  int get hashCode => Object.hash(id, title, body, isEvenDaySpecial, day);
}
