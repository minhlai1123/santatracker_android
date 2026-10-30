import 'village_storage.dart';

class MemoryVillageStorage implements VillageStorage {
  final Set<String> _storage = <String>{};
  bool shouldFailLoad = false;
  bool shouldFailSave = false;

  MemoryVillageStorage({Set<String>? initialIds}) {
    if (initialIds != null) {
      _storage.addAll(initialIds);
    }
  }

  @override
  Future<Set<String>> loadDiscoveredIds() async {
    if (shouldFailLoad) {
      throw Exception('Simulated load failure');
    }
    return Set<String>.from(_storage);
  }

  @override
  Future<bool> saveDiscoveredIds(Set<String> ids) async {
    if (shouldFailSave) {
      return false;
    }
    _storage
      ..clear()
      ..addAll(ids);
    return true;
  }
}
