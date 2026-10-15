import 'advent_chapter.dart';
import 'advent_chapter_status.dart';

class AdventStorybookState {
  final List<AdventChapter> chapters;
  final Set<int> unlockedChapterDays;
  final Set<int> readChapterDays;
  final AdventChapter? selectedChapter;
  final bool isLoading;

  const AdventStorybookState({
    required this.chapters,
    this.unlockedChapterDays = const {1},
    this.readChapterDays = const {},
    this.selectedChapter,
    this.isLoading = false,
  });

  int get totalChapters => chapters.length;

  int get unlockedCount => unlockedChapterDays.length;

  int get readCount => readChapterDays.length;

  bool get isAllUnlocked => totalChapters > 0 && unlockedCount >= totalChapters;

  bool get isAllRead => totalChapters > 0 && readCount >= totalChapters;

  double get unlockedPercentage =>
      totalChapters > 0 ? (unlockedCount / totalChapters).clamp(0.0, 1.0) : 0.0;

  double get readPercentage =>
      totalChapters > 0 ? (readCount / totalChapters).clamp(0.0, 1.0) : 0.0;

  AdventChapterStatus getChapterStatus(int dayNumber) {
    if (!unlockedChapterDays.contains(dayNumber)) {
      return AdventChapterStatus.locked;
    }
    if (readChapterDays.contains(dayNumber)) {
      return AdventChapterStatus.read;
    }
    return AdventChapterStatus.unlocked;
  }

  bool isChapterUnlocked(int dayNumber) =>
      unlockedChapterDays.contains(dayNumber);

  bool isChapterRead(int dayNumber) => readChapterDays.contains(dayNumber);

  AdventStorybookState copyWith({
    List<AdventChapter>? chapters,
    Set<int>? unlockedChapterDays,
    Set<int>? readChapterDays,
    AdventChapter? Function()? selectedChapter,
    bool? isLoading,
  }) {
    return AdventStorybookState(
      chapters: chapters ?? this.chapters,
      unlockedChapterDays: unlockedChapterDays ?? this.unlockedChapterDays,
      readChapterDays: readChapterDays ?? this.readChapterDays,
      selectedChapter: selectedChapter != null
          ? selectedChapter()
          : this.selectedChapter,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() =>
      'AdventStorybookState(unlocked: $unlockedCount/$totalChapters, '
      'read: $readCount/$totalChapters, loading: $isLoading)';
}
