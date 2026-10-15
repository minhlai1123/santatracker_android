import 'advent_storage.dart';

class MemoryAdventStorage implements AdventStorage {
  Set<int> _unlockedDays;
  Set<int> _readDays;

  MemoryAdventStorage({
    Set<int>? initialUnlockedDays,
    Set<int>? initialReadDays,
  }) : _unlockedDays = initialUnlockedDays != null
           ? Set<int>.from(initialUnlockedDays)
           : {1},
       _readDays = initialReadDays != null
           ? Set<int>.from(initialReadDays)
           : {};

  @override
  Future<Set<int>> loadUnlockedDays() async {
    return Set<int>.from(_unlockedDays);
  }

  @override
  Future<void> saveUnlockedDays(Set<int> days) async {
    _unlockedDays = Set<int>.from(days);
  }

  @override
  Future<Set<int>> loadReadDays() async {
    return Set<int>.from(_readDays);
  }

  @override
  Future<void> saveReadDays(Set<int> days) async {
    _readDays = Set<int>.from(days);
  }

  void reset() {
    _unlockedDays = {1};
    _readDays = {};
  }
}
