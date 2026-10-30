class NotificationSettings {
  final bool isEnabled;
  final int preferredHour;
  final int preferredMinute;
  final bool evenDaysSpecialEnabled;
  final String? lastNotifiedDate;

  const NotificationSettings({
    this.isEnabled = true,
    this.preferredHour = 9,
    this.preferredMinute = 0,
    this.evenDaysSpecialEnabled = true,
    this.lastNotifiedDate,
  });

  NotificationSettings copyWith({
    bool? isEnabled,
    int? preferredHour,
    int? preferredMinute,
    bool? evenDaysSpecialEnabled,
    String? lastNotifiedDate,
  }) {
    return NotificationSettings(
      isEnabled: isEnabled ?? this.isEnabled,
      preferredHour: preferredHour ?? this.preferredHour,
      preferredMinute: preferredMinute ?? this.preferredMinute,
      evenDaysSpecialEnabled:
          evenDaysSpecialEnabled ?? this.evenDaysSpecialEnabled,
      lastNotifiedDate: lastNotifiedDate ?? this.lastNotifiedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isEnabled': isEnabled,
      'preferredHour': preferredHour,
      'preferredMinute': preferredMinute,
      'evenDaysSpecialEnabled': evenDaysSpecialEnabled,
      'lastNotifiedDate': lastNotifiedDate,
    };
  }

  factory NotificationSettings.fromMap(Map<String, dynamic> map) {
    return NotificationSettings(
      isEnabled: map['isEnabled'] as bool? ?? true,
      preferredHour: map['preferredHour'] as int? ?? 9,
      preferredMinute: map['preferredMinute'] as int? ?? 0,
      evenDaysSpecialEnabled: map['evenDaysSpecialEnabled'] as bool? ?? true,
      lastNotifiedDate: map['lastNotifiedDate'] as String?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationSettings &&
          runtimeType == other.runtimeType &&
          isEnabled == other.isEnabled &&
          preferredHour == other.preferredHour &&
          preferredMinute == other.preferredMinute &&
          evenDaysSpecialEnabled == other.evenDaysSpecialEnabled &&
          lastNotifiedDate == other.lastNotifiedDate;

  @override
  int get hashCode => Object.hash(
    isEnabled,
    preferredHour,
    preferredMinute,
    evenDaysSpecialEnabled,
    lastNotifiedDate,
  );
}
