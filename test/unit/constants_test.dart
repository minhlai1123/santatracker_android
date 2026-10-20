import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/core/constants/app_dimensions.dart';
import 'package:chrimastsatastracker/core/constants/app_strings.dart';
import 'package:chrimastsatastracker/core/theme/app_colors.dart';
import 'package:chrimastsatastracker/core/theme/app_theme.dart';

void main() {
  group('AppConstants Unit Tests', () {
    test('AppStrings contains valid and non-empty texts', () {
      expect(AppStrings.appName, equals('Chrimastsatastracker'));
      expect(AppStrings.welcomeTitle, isNotEmpty);
      expect(AppStrings.welcomeSubtitle, isNotEmpty);
      expect(AppStrings.festiveTagline, isNotEmpty);
      expect(AppStrings.foundationStatusTitle, isNotEmpty);
      expect(AppStrings.foundationStatusDesc, isNotEmpty);
      expect(AppStrings.offlineFirstBadge, isNotEmpty);
      expect(AppStrings.privacyBadge, isNotEmpty);
      expect(AppStrings.holidayGreeting, isNotEmpty);

      // Phase 2 strings
      expect(AppStrings.homeTitle, isNotEmpty);
      expect(AppStrings.countdownPreviewTitle, isNotEmpty);
      expect(AppStrings.openCountdownButton, isNotEmpty);
      expect(AppStrings.comingSoonTitle, isNotEmpty);
      expect(AppStrings.countdownScreenTitle, isNotEmpty);
      expect(AppStrings.backToHomeButton, isNotEmpty);
      expect(AppStrings.messageChristmasDay, isNotEmpty);
      expect(AppStrings.messageUnder24Hours, isNotEmpty);
      expect(AppStrings.messageOneToSevenDays, isNotEmpty);
      expect(AppStrings.messageEightToThirtyDays, isNotEmpty);
      expect(AppStrings.messageOverThirtyDays, isNotEmpty);

      // Phase 3 strings
      expect(AppStrings.santaTrackerScreenTitle, isNotEmpty);
      expect(AppStrings.simulationBadgeLabel, equals('SIMULATION JOURNEY'));
      expect(AppStrings.offlineSimulationBanner, isNotEmpty);
      expect(AppStrings.statusNotStarted, isNotEmpty);
      expect(AppStrings.statusInProgress, isNotEmpty);
      expect(AppStrings.statusPaused, isNotEmpty);
      expect(AppStrings.statusCompleted, isNotEmpty);
      expect(AppStrings.startJourneyButton, isNotEmpty);
      expect(AppStrings.nextStopButton, isNotEmpty);
      expect(AppStrings.pauseJourneyButton, isNotEmpty);
      expect(AppStrings.resumeJourneyButton, isNotEmpty);
      expect(AppStrings.resetJourneyButton, isNotEmpty);

      // Phase 4 strings
      expect(AppStrings.villageScreenTitle, isNotEmpty);
      expect(AppStrings.villageSubtitle, isNotEmpty);
      expect(AppStrings.openVillageButton, isNotEmpty);
      expect(AppStrings.villageActiveBadge, equals('Active'));
      expect(AppStrings.villageProgressLabel, isNotEmpty);
      expect(AppStrings.villageCompletedBanner, isNotEmpty);
      expect(AppStrings.locationStatusDiscovered, equals('Discovered'));
      expect(AppStrings.locationStatusUndiscovered, equals('Undiscovered'));
      expect(AppStrings.discoverLocationButton, isNotEmpty);
      expect(AppStrings.selectLocationHint, isNotEmpty);

      // Phase 5 strings
      expect(AppStrings.miniGamesScreenTitle, isNotEmpty);
      expect(AppStrings.miniGamesSubtitle, isNotEmpty);
      expect(AppStrings.openMiniGamesButton, isNotEmpty);
      expect(AppStrings.miniGamesActiveBadge, equals('Active'));
      expect(AppStrings.memoryMatchTitle, isNotEmpty);
      expect(AppStrings.catchGiftsTitle, isNotEmpty);
      expect(AppStrings.adventScreenTitle, isNotEmpty);
      expect(AppStrings.adventSubtitle, isNotEmpty);
      expect(AppStrings.openAdventButton, isNotEmpty);
      expect(AppStrings.adventActiveBadge, equals('Active'));
      expect(AppStrings.adventStatusLocked, isNotEmpty);
      expect(AppStrings.adventStatusUnlocked, isNotEmpty);
      expect(AppStrings.adventStatusRead, isNotEmpty);
    });

    test(
      'AppDimensions values are positive and strictly ascending where expected',
      () {
        expect(AppDimensions.spaceXS, greaterThan(0));
        expect(AppDimensions.spaceSM, greaterThan(AppDimensions.spaceXS));
        expect(AppDimensions.spaceMD, greaterThan(AppDimensions.spaceSM));
        expect(AppDimensions.spaceLG, greaterThan(AppDimensions.spaceMD));
        expect(AppDimensions.spaceXL, greaterThan(AppDimensions.spaceLG));
        expect(AppDimensions.spaceXXL, greaterThan(AppDimensions.spaceXL));

        expect(AppDimensions.radiusSM, greaterThan(0));
        expect(AppDimensions.radiusMD, greaterThan(AppDimensions.radiusSM));
        expect(AppDimensions.radiusLG, greaterThan(AppDimensions.radiusMD));
      },
    );

    test(
      'AppTheme creates valid Material 3 ThemeData with Christmas palette',
      () {
        final theme = AppTheme.lightTheme;
        expect(theme.useMaterial3, isTrue);
        expect(theme.primaryColor, equals(AppColors.christmasRed));
        expect(theme.colorScheme.primary, equals(AppColors.christmasRed));
        expect(theme.colorScheme.secondary, equals(AppColors.pineGreen));
      },
    );
  });
}
