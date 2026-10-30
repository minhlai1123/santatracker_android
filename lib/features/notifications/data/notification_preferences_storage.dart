import 'package:shared_preferences/shared_preferences.dart';

import '../domain/models/notification_settings.dart';

class NotificationPreferencesStorage {
  static const String _keyEnabled = 'christmas_notifications_enabled';
  static const String _keyHour = 'christmas_notifications_hour';
  static const String _keyMinute = 'christmas_notifications_minute';
  static const String _keyEvenDaysSpecial =
      'christmas_notifications_even_days_special';
  static const String _keyLastDate = 'christmas_notifications_last_date';

  final SharedPreferences? _prefs;

  NotificationPreferencesStorage([this._prefs]);

  Future<SharedPreferences> _getPrefs() async {
    return _prefs ?? await SharedPreferences.getInstance();
  }

  Future<NotificationSettings> getSettings() async {
    final prefs = await _getPrefs();
    final isEnabled = prefs.getBool(_keyEnabled) ?? true;
    final hour = prefs.getInt(_keyHour) ?? 9;
    final minute = prefs.getInt(_keyMinute) ?? 0;
    final evenDaysSpecial = prefs.getBool(_keyEvenDaysSpecial) ?? true;
    final lastDate = prefs.getString(_keyLastDate);

    return NotificationSettings(
      isEnabled: isEnabled,
      preferredHour: hour,
      preferredMinute: minute,
      evenDaysSpecialEnabled: evenDaysSpecial,
      lastNotifiedDate: lastDate,
    );
  }

  Future<void> saveSettings(NotificationSettings settings) async {
    final prefs = await _getPrefs();
    await prefs.setBool(_keyEnabled, settings.isEnabled);
    await prefs.setInt(_keyHour, settings.preferredHour);
    await prefs.setInt(_keyMinute, settings.preferredMinute);
    await prefs.setBool(_keyEvenDaysSpecial, settings.evenDaysSpecialEnabled);
    if (settings.lastNotifiedDate != null) {
      await prefs.setString(_keyLastDate, settings.lastNotifiedDate!);
    }
  }

  Future<void> recordNotificationSent(DateTime date) async {
    final prefs = await _getPrefs();
    final dateString =
        '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    await prefs.setString(_keyLastDate, dateString);
  }

  Future<bool> hasNotifiedToday(DateTime date) async {
    final prefs = await _getPrefs();
    final lastDate = prefs.getString(_keyLastDate);
    final dateString =
        '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return lastDate == dateString;
  }
}
