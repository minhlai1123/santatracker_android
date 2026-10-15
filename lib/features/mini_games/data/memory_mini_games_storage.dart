import '../domain/models/mini_game_record.dart';
import 'mini_games_storage.dart';

class MemoryMiniGamesStorage implements MiniGamesStorage {
  MiniGameRecord _record;

  MemoryMiniGamesStorage({MiniGameRecord? initialRecord})
    : _record = initialRecord ?? const MiniGameRecord.initial();

  @override
  Future<MiniGameRecord> loadRecord() async {
    return _record;
  }

  @override
  Future<void> saveRecord(MiniGameRecord record) async {
    _record = record;
  }

  void reset() {
    _record = const MiniGameRecord.initial();
  }
}
