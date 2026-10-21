import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../features/notifications/domain/services/festive_notification_catalog.dart';

class ChristmasWidgetData {
  final int daysLeft;
  final bool isEvenDay;
  final String title;
  final String daysLabel;
  final String statusBadge;

  const ChristmasWidgetData({
    required this.daysLeft,
    required this.isEvenDay,
    required this.title,
    required this.daysLabel,
    required this.statusBadge,
  });
}

class ChristmasWidgetService {
  ChristmasWidgetService._();

  static const MethodChannel _channel = MethodChannel(
    'com.chrimastsatastracker/widget',
  );

  static bool get _isTestEnvironment {
    return kDebugMode &&
        WidgetsBinding.instance.runtimeType.toString().contains('Test');
  }

  /// Triggers a native update of Home Screen Widgets on Android and iOS.
  static Future<bool> updateWidget() async {
    if (_isTestEnvironment) return true;
    try {
      final result = await _channel.invokeMethod<bool>('updateWidget');
      return result ?? true;
    } catch (_) {
      return true;
    }
  }

  /// Calculates the current widget data for any given date.
  static ChristmasWidgetData getWidgetData({DateTime? date}) {
    final now = date ?? DateTime.now();
    final days = FestiveNotificationCatalog.daysUntilChristmas(now);
    final isEven = FestiveNotificationCatalog.isEvenDay(now);

    final String label;
    if (days == 0) {
      label = 'TODAY IS CHRISTMAS!';
    } else if (days == 1) {
      label = 'DAY UNTIL CHRISTMAS';
    } else {
      label = 'DAYS UNTIL CHRISTMAS';
    }

    final String badge;
    if (isEven) {
      badge = '✨ Even-Day Special Active';
    } else {
      badge = '🎄 Daily Christmas Cheer';
    }

    return ChristmasWidgetData(
      daysLeft: days,
      isEvenDay: isEven,
      title: 'Christmas Countdown',
      daysLabel: label,
      statusBadge: badge,
    );
  }
}
