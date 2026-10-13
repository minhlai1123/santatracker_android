abstract class VillageStorage {
  Future<Set<String>> loadDiscoveredIds();
  Future<bool> saveDiscoveredIds(Set<String> ids);
}
