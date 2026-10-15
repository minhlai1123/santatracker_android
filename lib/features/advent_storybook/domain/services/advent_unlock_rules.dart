import '../../../mini_games/domain/models/mini_game_record.dart';

class AdventUnlockRules {
  static const int totalDays = 24;

  static String getUnlockDescription(int dayNumber) {
    switch (dayNumber) {
      case 1:
        return 'Mở sẵn khi bắt đầu mùa lễ hội.';
      case 2:
        return 'Chiến thắng trò chơi Lật Thẻ Giáng Sinh lần đầu tiên.';
      case 3:
        return 'Hoàn thành trò chơi Bắt Quà Giáng Sinh lần đầu tiên.';
      case 4:
        return 'Đọc xong Chương 1 của cuốn sách.';
      case 5:
        return 'Đạt từ 10 điểm trở lên trong Bắt Quà Giáng Sinh.';
      case 6:
        return 'Thắng Lật Thẻ Giáng Sinh với từ 18 lượt thử trở xuống.';
      case 7:
        return 'Bắt được tổng cộng từ 15 hộp quà trong Bắt Quà Giáng Sinh.';
      case 8:
        return 'Đọc xong ít nhất 3 chương trong cuốn sách.';
      case 9:
        return 'Chiến thắng Lật Thẻ Giáng Sinh từ 2 lần trở lên.';
      case 10:
        return 'Đạt điểm cao từ 20 điểm trở lên trong Bắt Quà Giáng Sinh.';
      case 11:
        return 'Hoàn thành từ 2 lượt chơi Bắt Quà Giáng Sinh trở lên.';
      case 12:
        return 'Đọc xong ít nhất 6 chương trong cuốn sách.';
      case 13:
        return 'Thắng Lật Thẻ Giáng Sinh với từ 14 lượt thử trở xuống.';
      case 14:
        return 'Bắt được tổng cộng từ 35 hộp quà trong Bắt Quà Giáng Sinh.';
      case 15:
        return 'Chiến thắng Lật Thẻ Giáng Sinh từ 3 lần trở lên.';
      case 16:
        return 'Đạt điểm cao từ 30 điểm trở lên trong Bắt Quà Giáng Sinh.';
      case 17:
        return 'Hoàn thành từ 3 lượt chơi Bắt Quà Giáng Sinh trở lên.';
      case 18:
        return 'Đọc xong ít nhất 10 chương trong cuốn sách.';
      case 19:
        return 'Thắng Lật Thẻ với <= 12 lượt hoặc thắng từ 4 lần trở lên.';
      case 20:
        return 'Bắt được tổng cộng từ 60 hộp quà trong Bắt Quà Giáng Sinh.';
      case 21:
        return 'Đọc xong ít nhất 15 chương trong cuốn sách.';
      case 22:
        return 'Chiến thắng Lật Thẻ Giáng Sinh từ 5 lần trở lên.';
      case 23:
        return 'Đạt điểm cao >= 40 hoặc tổng quà bắt được >= 80.';
      case 24:
        return 'Đã mở khóa 23 chương trước và đọc ít nhất 18 chương.';
      default:
        return 'Chưa rõ điều kiện mở khóa.';
    }
  }

  static bool isConditionMet({
    required int dayNumber,
    required MiniGameRecord record,
    required Set<int> unlockedDays,
    required Set<int> readDays,
  }) {
    // Monotonic: if already unlocked, stays unlocked
    if (unlockedDays.contains(dayNumber)) {
      return true;
    }

    switch (dayNumber) {
      case 1:
        return true;
      case 2:
        return record.memoryMatchCompletions >= 1;
      case 3:
        return record.catchGiftsCompletions >= 1;
      case 4:
        return readDays.contains(1);
      case 5:
        return record.catchGiftsHighScore >= 10;
      case 6:
        return record.memoryMatchBestMoves != null &&
            record.memoryMatchBestMoves! > 0 &&
            record.memoryMatchBestMoves! <= 18;
      case 7:
        return record.catchGiftsTotalGifts >= 15;
      case 8:
        return readDays.length >= 3;
      case 9:
        return record.memoryMatchCompletions >= 2;
      case 10:
        return record.catchGiftsHighScore >= 20;
      case 11:
        return record.catchGiftsCompletions >= 2;
      case 12:
        return readDays.length >= 6;
      case 13:
        return record.memoryMatchBestMoves != null &&
            record.memoryMatchBestMoves! > 0 &&
            record.memoryMatchBestMoves! <= 14;
      case 14:
        return record.catchGiftsTotalGifts >= 35;
      case 15:
        return record.memoryMatchCompletions >= 3;
      case 16:
        return record.catchGiftsHighScore >= 30;
      case 17:
        return record.catchGiftsCompletions >= 3;
      case 18:
        return readDays.length >= 10;
      case 19:
        final hasGreatMoves =
            record.memoryMatchBestMoves != null &&
            record.memoryMatchBestMoves! > 0 &&
            record.memoryMatchBestMoves! <= 12;
        return hasGreatMoves || record.memoryMatchCompletions >= 4;
      case 20:
        return record.catchGiftsTotalGifts >= 60;
      case 21:
        return readDays.length >= 15;
      case 22:
        return record.memoryMatchCompletions >= 5;
      case 23:
        return record.catchGiftsHighScore >= 40 ||
            record.catchGiftsTotalGifts >= 80;
      case 24:
        final unlockedOthers = unlockedDays.where((d) => d < 24).length;
        return unlockedOthers >= 23 && readDays.length >= 18;
      default:
        return false;
    }
  }

  static Set<int> evaluateAllUnlocked({
    required MiniGameRecord record,
    required Set<int> existingUnlocked,
    required Set<int> readDays,
  }) {
    final result = Set<int>.from(existingUnlocked);
    result.add(1); // Day 1 always unlocked

    // Evaluate iteratively because unlocking one chapter can satisfy a subsequent condition
    bool changed = true;
    while (changed) {
      changed = false;
      for (int day = 1; day <= totalDays; day++) {
        if (!result.contains(day)) {
          if (isConditionMet(
            dayNumber: day,
            record: record,
            unlockedDays: result,
            readDays: readDays,
          )) {
            result.add(day);
            changed = true;
          }
        }
      }
    }

    return result;
  }
}
