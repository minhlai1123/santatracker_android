import 'package:flutter/material.dart';

import '../../../../core/services/christmas_notification_service.dart';
import '../../data/notification_preferences_storage.dart';
import '../../domain/models/festive_notification_item.dart';
import '../../domain/models/notification_settings.dart';
import '../../domain/services/festive_notification_catalog.dart';

class NotificationSettingsController extends ChangeNotifier {
  final NotificationPreferencesStorage _storage;
  final DateTime Function()? clock;

  NotificationSettings _settings = const NotificationSettings();
  bool _isLoading = true;
  String? _statusMessage;

  NotificationSettingsController({
    NotificationPreferencesStorage? storage,
    this.clock,
  }) : _storage = storage ?? NotificationPreferencesStorage();

  NotificationSettings get settings => _settings;
  bool get isLoading => _isLoading;
  String? get statusMessage => _statusMessage;

  DateTime get _now => clock?.call() ?? DateTime.now();

  FestiveNotificationItem get todayNotification =>
      FestiveNotificationCatalog.getNotificationForDate(_now);

  bool get isTodayEvenDay => FestiveNotificationCatalog.isEvenDay(_now);

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();

    _settings = await _storage.getSettings();
    _isLoading = false;
    notifyListeners();

    // Ensure scheduled state matches settings on app start
    if (_settings.isEnabled) {
      await ChristmasNotificationService.scheduleDailyNotification(
        _settings.preferredHour,
        _settings.preferredMinute,
      );
    }
  }

  Future<void> toggleEnabled(bool enabled) async {
    _settings = _settings.copyWith(isEnabled: enabled);
    notifyListeners();
    await _storage.saveSettings(_settings);

    if (enabled) {
      await ChristmasNotificationService.requestPermission();
      await ChristmasNotificationService.scheduleDailyNotification(
        _settings.preferredHour,
        _settings.preferredMinute,
      );
      _statusMessage =
          'Daily reminders enabled for ${_formatTime(_settings.preferredHour, _settings.preferredMinute)}';
    } else {
      await ChristmasNotificationService.cancelDailyNotification();
      _statusMessage = 'Daily reminders disabled';
    }
    notifyListeners();
  }

  Future<void> updateTime(int hour, int minute) async {
    _settings = _settings.copyWith(
      preferredHour: hour,
      preferredMinute: minute,
    );
    notifyListeners();
    await _storage.saveSettings(_settings);

    if (_settings.isEnabled) {
      await ChristmasNotificationService.scheduleDailyNotification(
        hour,
        minute,
      );
    }
    _statusMessage = 'Reminder time updated to ${_formatTime(hour, minute)}';
    notifyListeners();
  }

  Future<void> toggleEvenDaysSpecial(bool enabled) async {
    _settings = _settings.copyWith(evenDaysSpecialEnabled: enabled);
    notifyListeners();
    await _storage.saveSettings(_settings);
  }

  Future<FestiveNotificationItem> sendTestNotification() async {
    final item = await ChristmasNotificationService.sendTestNotification(
      date: _now,
    );
    await _storage.recordNotificationSent(_now);
    _statusMessage = 'Test notification sent!';
    notifyListeners();
    return item;
  }

  static String _formatTime(int hour, int minute) {
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0
        ? 12
        : hour > 12
        ? hour - 12
        : hour;
    final displayMinute = minute.toString().padLeft(2, '0');
    return '$displayHour:$displayMinute $period';
  }
}
