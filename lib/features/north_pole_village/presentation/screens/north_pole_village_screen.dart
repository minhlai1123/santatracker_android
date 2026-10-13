import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../shared/widgets/festive_button.dart';
import '../../data/village_storage.dart';
import '../../domain/models/village_location.dart';
import '../controllers/village_controller.dart';
import '../widgets/village_location_detail_sheet.dart';
import '../widgets/village_map.dart';
import '../widgets/village_progress_header.dart';

class NorthPoleVillageScreen extends StatefulWidget {
  final VillageController? controller;
  final VillageStorage? storage;
  final List<VillageLocation>? locations;

  const NorthPoleVillageScreen({
    super.key,
    this.controller,
    this.storage,
    this.locations,
  });

  @override
  State<NorthPoleVillageScreen> createState() => _NorthPoleVillageScreenState();
}

class _NorthPoleVillageScreenState extends State<NorthPoleVillageScreen> {
  late final VillageController _controller;
  late final bool _ownsController;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller =
        widget.controller ??
        VillageController(storage: widget.storage, locations: widget.locations);
    _controller.init();
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.villageScreenTitle)),
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
                      VillageProgressHeader(state: state),
                      const SizedBox(height: AppDimensions.spaceLG),
                      VillageMap(
                        locations: state.locations,
                        discoveredLocationIds: state.discoveredLocationIds,
                        selectedLocationId: state.selectedLocationId,
                        onSelectLocation: (id) =>
                            _controller.selectLocation(id),
                      ),
                      const SizedBox(height: AppDimensions.spaceLG),
                      VillageLocationDetailSheet(
                        location: state.selectedLocation,
                        isDiscovered: state.isSelectedLocationDiscovered,
                        onDiscover: () =>
                            _controller.markSelectedLocationAsDiscovered(),
                        onClose: () => _controller.selectLocation(null),
                      ),
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
