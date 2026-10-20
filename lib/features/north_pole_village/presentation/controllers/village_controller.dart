import 'package:flutter/foundation.dart';

import '../../data/shared_preferences_village_storage.dart';
import '../../data/village_storage.dart';
import '../../domain/models/village_exploration_state.dart';
import '../../domain/models/village_location.dart';
import '../../domain/services/north_pole_village_data.dart';

class VillageController extends ChangeNotifier {
  final VillageStorage _storage;
  late VillageExplorationState _state;
  bool _isDisposed = false;

  VillageController({VillageStorage? storage, List<VillageLocation>? locations})
    : _storage = storage ?? SharedPreferencesVillageStorage() {
    final villageLocations = locations ?? NorthPoleVillageData.defaultLocations;
    _state = VillageExplorationState.initial(villageLocations);
  }

  VillageExplorationState get state => _state;

  bool get isDisposed => _isDisposed;

  Future<void> init() async {
    if (_isDisposed) return;
    _state = _state.copyWith(isLoading: true, errorMessage: () => null);
    notifyListeners();

    try {
      final loadedIds = await _storage.loadDiscoveredIds();
      if (_isDisposed) return;

      // Filter to only recognized location IDs in this village
      final validLocationIds = _state.locations.map((loc) => loc.id).toSet();
      final filteredIds = loadedIds.where(validLocationIds.contains).toSet();

      _state = _state.copyWith(
        discoveredLocationIds: filteredIds,
        isLoading: false,
        errorMessage: () => null,
      );
    } catch (_) {
      if (_isDisposed) return;
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: () => 'Failed to load discovery data',
      );
    }
    notifyListeners();
  }

  void selectLocation(String? id) {
    if (_isDisposed) return;
    if (_state.selectedLocationId == id) return;

    if (id != null && !_state.locations.any((loc) => loc.id == id)) {
      return;
    }

    _state = _state.copyWith(selectedLocationId: () => id);
    notifyListeners();
  }

  Future<bool> markLocationAsDiscovered(String id) async {
    if (_isDisposed) return false;
    final locationExists = _state.locations.any((loc) => loc.id == id);
    if (!locationExists) return false;

    // If already discovered, operation is idempotent
    if (_state.isDiscovered(id)) {
      return true;
    }

    final updatedIds = Set<String>.from(_state.discoveredLocationIds)..add(id);

    try {
      final saved = await _storage.saveDiscoveredIds(updatedIds);
      if (_isDisposed) return saved;

      if (saved) {
        _state = _state.copyWith(
          discoveredLocationIds: updatedIds,
          errorMessage: () => null,
        );
        notifyListeners();
        return true;
      } else {
        _state = _state.copyWith(
          errorMessage: () => 'Failed to save discovery progress',
        );
        notifyListeners();
        return false;
      }
    } catch (_) {
      if (_isDisposed) return false;
      _state = _state.copyWith(
        errorMessage: () => 'Failed to save discovery progress',
      );
      notifyListeners();
      return false;
    }
  }

  Future<bool> markSelectedLocationAsDiscovered() async {
    final selectedId = _state.selectedLocationId;
    if (selectedId == null) return false;
    return await markLocationAsDiscovered(selectedId);
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
