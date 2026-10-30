import 'package:shared_preferences/shared_preferences.dart';

import 'village_storage.dart';

class SharedPreferencesVillageStorage implements VillageStorage {
  static const String storageKey = 'discovered_village_locations_v1';

  final Future<SharedPreferences> Function() _preferencesProvider;

  SharedPreferencesVillageStorage({
    Future<SharedPreferences> Function()? preferencesProvider,
  }) : _preferencesProvider =
           preferencesProvider ?? SharedPreferences.getInstance;

  @override
  Future<Set<String>> loadDiscoveredIds() async {
    try {
      final prefs = await _preferencesProvider();
      final list = prefs.getStringList(storageKey);
      if (list == null || list.isEmpty) {
        return <String>{};
      }
      return list.where((id) => id.trim().isNotEmpty).toSet();
    } catch (_) {
      return <String>{};
    }
  }

  @override
  Future<bool> saveDiscoveredIds(Set<String> ids) async {
    try {
      final prefs = await _preferencesProvider();
      final list = ids.where((id) => id.trim().isNotEmpty).toList();
      return await prefs.setStringList(storageKey, list);
    } catch (_) {
      return false;
    }
  }
}
