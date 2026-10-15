import '../domain/models/mini_game_record.dart';

abstract class MiniGamesStorage {
  Future<MiniGameRecord> loadRecord();
  Future<void> saveRecord(MiniGameRecord record);
}
