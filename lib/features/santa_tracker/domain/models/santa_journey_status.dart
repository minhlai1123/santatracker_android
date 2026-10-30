import '../../../../core/constants/app_strings.dart';

enum SantaJourneyStatus {
  notStarted,
  inProgress,
  paused,
  completed;

  String get label {
    switch (this) {
      case SantaJourneyStatus.notStarted:
        return AppStrings.statusNotStarted;
      case SantaJourneyStatus.inProgress:
        return AppStrings.statusInProgress;
      case SantaJourneyStatus.paused:
        return AppStrings.statusPaused;
      case SantaJourneyStatus.completed:
        return AppStrings.statusCompleted;
    }
  }
}
