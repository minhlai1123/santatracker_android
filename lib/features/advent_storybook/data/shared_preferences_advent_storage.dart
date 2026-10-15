import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'advent_storage.dart';

class SharedPreferencesAdventStorage implements AdventStorage {
  static const String keyUnlockedDays = 'advent_unlocked_days';
  static const String keyReadDays = 'advent_read_days';

  const SharedPreferencesAdventStorage();

  @override
  Future<Set<int>> loadUnlockedDays() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(keyUnlockedDays);
      if (list == null || list.isEmpty) {
        return {1}; // Day 1 is unlocked by default
      }

      final Set<int> result = {1};
      for (final item in list) {
        final parsed = int.tryParse(item.trim());
        if (parsed != null && parsed >= 1 && parsed <= 24) {
          result.add(parsed);
        }
      }
      return result;
    } catch (e, stackTrace) {
      debugPrint(
        'SharedPreferencesAdventStorage: Lỗi khi nạp danh sách mở khóa: $e\n$stackTrace',
      );
      return {1};
    }
  }

  @override
  Future<void> saveUnlockedDays(Set<int> days) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final validList = days
          .where((d) => d >= 1 && d <= 24)
          .map((d) => d.toString())
          .toList();
      await prefs.setStringList(keyUnlockedDays, validList);
    } catch (e, stackTrace) {
      debugPrint(
        'SharedPreferencesAdventStorage: Lỗi khi lưu danh sách mở khóa: $e\n$stackTrace',
      );
    }
  }

  @override
  Future<Set<int>> loadReadDays() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(keyReadDays);
      if (list == null || list.isEmpty) {
        return {};
      }

      final Set<int> result = {};
      for (final item in list) {
        final parsed = int.tryParse(item.trim());
        if (parsed != null && parsed >= 1 && parsed <= 24) {
          result.add(parsed);
        }
      }
      return result;
    } catch (e, stackTrace) {
      debugPrint(
        'SharedPreferencesAdventStorage: Lỗi khi nạp danh sách đã đọc: $e\n$stackTrace',
      );
      return {};
    }
  }

  @override
  Future<void> saveReadDays(Set<int> days) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final validList = days
          .where((d) => d >= 1 && d <= 24)
          .map((d) => d.toString())
          .toList();
      await prefs.setStringList(keyReadDays, validList);
    } catch (e, stackTrace) {
      debugPrint(
        'SharedPreferencesAdventStorage: Lỗi khi lưu danh sách đã đọc: $e\n$stackTrace',
      );
    }
  }
}
