class AdventChapter {
  final int dayNumber;
  final String id;
  final String title;
  final String unlockRuleDescription;
  final String storyContent;
  final String festiveMessage;
  final String activityOrRiddle;

  const AdventChapter({
    required this.dayNumber,
    required this.id,
    required this.title,
    required this.unlockRuleDescription,
    required this.storyContent,
    required this.festiveMessage,
    required this.activityOrRiddle,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdventChapter &&
          runtimeType == other.runtimeType &&
          dayNumber == other.dayNumber &&
          id == other.id;

  @override
  int get hashCode => dayNumber.hashCode ^ id.hashCode;

  @override
  String toString() => 'AdventChapter(day: $dayNumber, id: $id, title: $title)';
}
