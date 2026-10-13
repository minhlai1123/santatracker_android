import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../../../welcome/presentation/widgets/festive_badge.dart';
import '../../domain/models/santa_stop.dart';
import '../../domain/services/network_status_provider.dart';
import '../controllers/santa_tracker_controller.dart';
import '../widgets/santa_control_panel.dart';
import '../widgets/santa_journey_info_card.dart';
import '../widgets/santa_offline_banner.dart';
import '../widgets/santa_world_map.dart';

class SantaTrackerScreen extends StatefulWidget {
  final SantaTrackerController? controller;
  final NetworkStatusProvider? networkStatusProvider;
  final List<SantaStop>? stops;

  const SantaTrackerScreen({
    super.key,
    this.controller,
    this.networkStatusProvider,
    this.stops,
  });

  @override
  State<SantaTrackerScreen> createState() => _SantaTrackerScreenState();
}

class _SantaTrackerScreenState extends State<SantaTrackerScreen>
    with WidgetsBindingObserver {
  late final SantaTrackerController _controller;
  late final bool _ownsController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _ownsController = widget.controller == null;
    _controller =
        widget.controller ??
        SantaTrackerController(
          stops: widget.stops,
          networkStatusProvider: widget.networkStatusProvider,
        );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _controller.handleAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.santaTrackerScreenTitle)),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final state = _controller.state;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spaceLG,
                  vertical: AppDimensions.spaceLG,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                        child: FestiveBadge(
                          label: AppStrings.simulationBadgeLabel,
                          icon: Icons.public_rounded,
                          backgroundColor: AppColors.redTint,
                          textColor: AppColors.christmasRed,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spaceSM),
                      const Text(
                        AppStrings.simulationSubtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                      if (state.isOffline) ...[
                        const SizedBox(height: AppDimensions.spaceMD),
                        SantaOfflineBanner(isOffline: state.isOffline),
                      ],
                      const SizedBox(height: AppDimensions.spaceMD),
                      SantaWorldMap(
                        state: state,
                        shouldAnimateMarker: _controller.shouldAnimateMarker,
                      ),
                      const SizedBox(height: AppDimensions.spaceLG),
                      SantaControlPanel(
                        state: state,
                        onStart: _controller.startJourney,
                        onNextStop: _controller.advanceToNextStop,
                        onPause: _controller.pauseJourney,
                        onResume: _controller.resumeJourney,
                        onReset: _controller.resetJourney,
                      ),
                      const SizedBox(height: AppDimensions.spaceLG),
                      SantaJourneyInfoCard(state: state),
                      if (Navigator.of(context).canPop()) ...[
                        const SizedBox(height: AppDimensions.spaceLG),
                        FestiveButton(
                          label: AppStrings.backToHomeButton,
                          icon: Icons.home_outlined,
                          style: FestiveButtonStyle.secondary,
                          isExpanded: true,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
