import 'package:flutter/foundation.dart';

import 'village_location.dart';

class VillageExplorationState {
  final List<VillageLocation> locations;
  final Set<String> discoveredLocationIds;
  final String? selectedLocationId;
  final bool isLoading;
  final String? errorMessage;

  VillageExplorationState({
    required List<VillageLocation> locations,
    required Set<String> discoveredLocationIds,
    this.selectedLocationId,
    this.isLoading = false,
    this.errorMessage,
  }) : locations = List.unmodifiable(locations),
       discoveredLocationIds = Set.unmodifiable(discoveredLocationIds);

  factory VillageExplorationState.initial(List<VillageLocation> locations) {
    return VillageExplorationState(
      locations: locations,
      discoveredLocationIds: const <String>{},
      selectedLocationId: null,
      isLoading: false,
      errorMessage: null,
    );
  }

  int get totalCount => locations.length;

  int get discoveredCount => discoveredLocationIds.length;

  bool get isFullyExplored => totalCount > 0 && discoveredCount == totalCount;

  double get progressRatio =>
      totalCount == 0 ? 0.0 : (discoveredCount / totalCount).clamp(0.0, 1.0);

  bool isDiscovered(String id) => discoveredLocationIds.contains(id);

  VillageLocation? get selectedLocation {
    if (selectedLocationId == null) return null;
    for (final loc in locations) {
      if (loc.id == selectedLocationId) return loc;
    }
    return null;
  }

  bool get isSelectedLocationDiscovered {
    if (selectedLocationId == null) return false;
    return isDiscovered(selectedLocationId!);
  }

  String get progressDisplay => '$discoveredCount / $totalCount địa điểm';

  VillageExplorationState copyWith({
    List<VillageLocation>? locations,
    Set<String>? discoveredLocationIds,
    String? Function()? selectedLocationId,
    bool? isLoading,
    String? Function()? errorMessage,
  }) {
    return VillageExplorationState(
      locations: locations ?? this.locations,
      discoveredLocationIds:
          discoveredLocationIds ?? this.discoveredLocationIds,
      selectedLocationId: selectedLocationId != null
          ? selectedLocationId()
          : this.selectedLocationId,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VillageExplorationState &&
        listEquals(other.locations, locations) &&
        setEquals(other.discoveredLocationIds, discoveredLocationIds) &&
        other.selectedLocationId == selectedLocationId &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => Object.hash(
    Object.hashAll(locations),
    Object.hashAll(discoveredLocationIds),
    selectedLocationId,
    isLoading,
    errorMessage,
  );
}
