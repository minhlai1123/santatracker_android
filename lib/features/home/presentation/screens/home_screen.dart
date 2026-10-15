import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../../../advent_storybook/presentation/screens/advent_storybook_screen.dart';
import '../../../countdown/presentation/screens/countdown_screen.dart';
import '../../../mini_games/presentation/screens/christmas_mini_games_screen.dart';
import '../../../north_pole_village/presentation/screens/north_pole_village_screen.dart';
import '../../../santa_tracker/presentation/screens/santa_tracker_screen.dart';
import '../../../welcome/presentation/screens/welcome_screen.dart';
import '../widgets/home_advent_storybook_card.dart';
import '../widgets/home_countdown_preview_card.dart';
import '../widgets/home_header.dart';
import '../widgets/home_mini_games_card.dart';
import '../widgets/home_santa_tracker_card.dart';
import '../widgets/home_village_card.dart';

class HomeScreen extends StatelessWidget {
  final DateTime Function()? clock;

  const HomeScreen({super.key, this.clock});

  void _navigateToCountdown(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => CountdownScreen(clock: clock)));
  }

  void _navigateToSantaTracker(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const SantaTrackerScreen()));
  }

  void _navigateToVillage(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const NorthPoleVillageScreen()));
  }

  void _navigateToMiniGames(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const ChristmasMiniGamesScreen()));
  }

  void _navigateToAdvent(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const AdventStorybookScreen()));
  }

  void _navigateToWelcome(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const WelcomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline_rounded),
            tooltip: AppStrings.aboutAppButton,
            onPressed: () => _navigateToWelcome(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spaceLG,
              vertical: AppDimensions.spaceLG,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 540),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const HomeHeader(),
                  const SizedBox(height: AppDimensions.spaceXL),
                  HomeCountdownPreviewCard(
                    onOpenCountdown: () => _navigateToCountdown(context),
                    clock: clock,
                  ),
                  const SizedBox(height: AppDimensions.spaceLG),
                  HomeSantaTrackerCard(
                    onOpenSantaTracker: () => _navigateToSantaTracker(context),
                  ),
                  const SizedBox(height: AppDimensions.spaceLG),
                  HomeVillageCard(
                    onOpenVillage: () => _navigateToVillage(context),
                  ),
                  const SizedBox(height: AppDimensions.spaceLG),
                  HomeMiniGamesCard(
                    onOpenMiniGames: () => _navigateToMiniGames(context),
                  ),
                  const SizedBox(height: AppDimensions.spaceLG),
                  HomeAdventStorybookCard(
                    onOpenAdvent: () => _navigateToAdvent(context),
                  ),
                  const SizedBox(height: AppDimensions.spaceXL),
                  FestiveButton(
                    label: AppStrings.aboutAppButton,
                    icon: Icons.info_outline_rounded,
                    style: FestiveButtonStyle.outlined,
                    isExpanded: true,
                    onPressed: () => _navigateToWelcome(context),
                  ),
                  const SizedBox(height: AppDimensions.spaceXL),
                  const Text(
                    AppStrings.holidayGreeting,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
