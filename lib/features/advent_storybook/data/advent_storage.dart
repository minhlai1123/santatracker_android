abstract class AdventStorage {
  Future<Set<int>> loadUnlockedDays();
  Future<void> saveUnlockedDays(Set<int> days);
  Future<Set<int>> loadReadDays();
  Future<void> saveReadDays(Set<int> days);
}
