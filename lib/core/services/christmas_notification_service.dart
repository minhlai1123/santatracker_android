import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../features/notifications/domain/models/festive_notification_item.dart';
import '../../features/notifications/domain/services/festive_notification_catalog.dart';

class ChristmasNotificationService {
  ChristmasNotificationService._();

  static const MethodChannel _channel = MethodChannel(
    'com.chrimastsatastracker/notifications',
  );

  /// Whether current environment is a widget/unit test.
  static bool get _isTestEnvironment {
    return kDebugMode &&
        WidgetsBinding.instance.runtimeType.toString().contains('Test');
  }

  /// Check if notification permission is granted on the device.
  static Future<bool> checkPermission() async {
    if (_isTestEnvironment) return true;
    try {
      final granted = await _channel.invokeMethod<bool>('checkPermission');
      return granted ?? true;
    } catch (_) {
      return true;
    }
  }

  /// Request runtime notification permission (Android 13+ / iOS).
  static Future<bool> requestPermission() async {
    if (_isTestEnvironment) return true;
    try {
      final granted = await _channel.invokeMethod<bool>('requestPermission');
      return granted ?? true;
    } catch (_) {
      return true;
    }
  }

  /// Show an immediate festive notification.
  static Future<bool> showNotification(FestiveNotificationItem item) async {
    if (_isTestEnvironment) return true;
    try {
      final result = await _channel.invokeMethod<bool>('showNotification', {
        'id': item.id,
        'title': item.title,
        'body': item.body,
        'isEvenDaySpecial': item.isEvenDaySpecial,
        'day': item.day,
        'payload': item.payload ?? 'home',
      });
      return result ?? true;
    } catch (_) {
      return true;
    }
  }

  /// Schedule daily notification alarm on Android/iOS at [hour]:[minute].
  static Future<bool> scheduleDailyNotification(int hour, int minute) async {
    if (_isTestEnvironment) return true;
    try {
      final result = await _channel.invokeMethod<bool>('scheduleDaily', {
        'hour': hour,
        'minute': minute,
      });
      return result ?? true;
    } catch (_) {
      return true;
    }
  }

  /// Cancel all scheduled daily reminders.
  static Future<bool> cancelDailyNotification() async {
    if (_isTestEnvironment) return true;
    try {
      final result = await _channel.invokeMethod<bool>('cancelDaily');
      return result ?? true;
    } catch (_) {
      return true;
    }
  }

  /// Generate today's notification item and trigger an immediate test notification.
  static Future<FestiveNotificationItem> sendTestNotification({
    DateTime? date,
  }) async {
    final targetDate = date ?? DateTime.now();
    final item = FestiveNotificationCatalog.getNotificationForDate(targetDate);
    await showNotification(item);
    return item;
  }
}
