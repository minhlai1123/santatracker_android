import '../../../mini_games/domain/models/mini_game_record.dart';

class AdventUnlockRules {
  static const int totalDays = 24;

  static String getUnlockDescription(int dayNumber) {
    switch (dayNumber) {
      case 1:
        return 'Available from the start of the holiday season.';
      case 2:
        return 'Win the Holiday Memory Match game for the first time.';
      case 3:
        return 'Complete the Catch the Gifts game for the first time.';
      case 4:
        return 'Finish reading Chapter 1 of the storybook.';
      case 5:
        return 'Score 10 points or more in Catch the Gifts.';
      case 6:
        return 'Win Memory Match in 18 moves or fewer.';
      case 7:
        return 'Catch a total of 15 gifts in Catch the Gifts.';
      case 8:
        return 'Read at least 3 chapters in the storybook.';
      case 9:
        return 'Win Memory Match 2 or more times.';
      case 10:
        return 'Achieve a score of 20 points or higher in Catch the Gifts.';
      case 11:
        return 'Complete 2 or more rounds of Catch the Gifts.';
      case 12:
        return 'Read at least 6 chapters in the storybook.';
      case 13:
        return 'Win Memory Match in 14 moves or fewer.';
      case 14:
        return 'Catch a total of 35 gifts in Catch the Gifts.';
      case 15:
        return 'Win Memory Match 3 or more times.';
      case 16:
        return 'Achieve a score of 30 points or higher in Catch the Gifts.';
      case 17:
        return 'Complete 3 or more rounds of Catch the Gifts.';
      case 18:
        return 'Read at least 10 chapters in the storybook.';
      case 19:
        return 'Win Memory Match in <= 12 moves or win 4 or more times.';
      case 20:
        return 'Catch a total of 60 gifts in Catch the Gifts.';
      case 21:
        return 'Read at least 15 chapters in the storybook.';
      case 22:
        return 'Win Memory Match 5 or more times.';
      case 23:
        return 'Achieve a score >= 40 or catch >= 80 gifts total.';
      case 24:
        return 'Unlock all 23 previous chapters and read at least 18 chapters.';
      default:
        return 'Unlock condition unknown.';
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
