import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/features/north_pole_village/data/memory_village_storage.dart';
import 'package:chrimastsatastracker/features/north_pole_village/domain/models/village_location.dart';
import 'package:chrimastsatastracker/features/north_pole_village/domain/services/north_pole_village_data.dart';
import 'package:chrimastsatastracker/features/north_pole_village/presentation/controllers/village_controller.dart';

void main() {
  group('NorthPoleVillageData & VillageLocation Unit Tests', () {
    const locations = NorthPoleVillageData.defaultLocations;

    test('1. Village data contains at least 8 interactive locations', () {
      expect(locations.length, greaterThanOrEqualTo(8));
    });

    test('2. All location IDs are non-empty, unique, stable, and have sequential order', () {
      final seenIds = <String>{};
      for (int i = 0; i < locations.length; i++) {
        final loc = locations[i];
        expect(loc.id.trim(), isNotEmpty);
        expect(loc.name.trim(), isNotEmpty);
        expect(loc.description.trim(), isNotEmpty);
        expect(loc.details.trim(), isNotEmpty);
        expect(loc.order, equals(i));
        expect(
          seenIds.add(loc.id),
          isTrue,
          reason: 'Duplicate location id: ${loc.id}',
        );
      }
    });

    test('3. Every location has normalized coordinates within [0.0, 1.0]', () {
      for (final loc in locations) {
        expect(loc.normalizedX, inInclusiveRange(0.0, 1.0));
        expect(loc.normalizedY, inInclusiveRange(0.0, 1.0));
      }
    });

    test('4. Every location has valid type with label and icon', () {
      for (final loc in locations) {
        expect(loc.type.label, isNotEmpty);
        expect(loc.type.icon, isNotNull);
      }
    });

    test(
      'VillageLocation value equality, hashCode, and toString work properly',
      () {
        final first = locations.first;
        final copy = VillageLocation(
          id: first.id,
          name: first.name,
          type: first.type,
          description: first.description,
          details: first.details,
          normalizedX: first.normalizedX,
          normalizedY: first.normalizedY,
          order: first.order,
        );

        expect(first, equals(copy));
        expect(first.hashCode, equals(copy.hashCode));
        expect(first.toString(), contains(first.id));
      },
    );
  });

  group('VillageController & VillageExplorationState Domain Logic Tests', () {
    const locations = NorthPoleVillageData.defaultLocations;
    late MemoryVillageStorage storage;
    late VillageController controller;

    setUp(() {
      storage = MemoryVillageStorage();
      controller = VillageController(storage: storage, locations: locations);
    });

    tearDown(() {
      if (!controller.isDisposed) {
        controller.dispose();
      }
    });

    test('5. Initial state has 0 discovered locations and 0% progress', () {
      expect(controller.state.discoveredCount, equals(0));
      expect(controller.state.totalCount, equals(locations.length));
      expect(controller.state.progressRatio, equals(0.0));
      expect(controller.state.isFullyExplored, isFalse);
      expect(controller.state.selectedLocationId, isNull);
      expect(
        controller.state.progressDisplay,
        equals('0 / ${locations.length} địa điểm'),
      );
    });

    test(
      '6. Selecting location updates selectedLocation and ignores invalid IDs',
      () {
        controller.selectLocation('christmas_plaza');
        expect(controller.state.selectedLocationId, equals('christmas_plaza'));
        expect(controller.state.selectedLocation, isNotNull);
        expect(
          controller.state.selectedLocation!.name,
          equals('Quảng Trường Lễ Hội'),
        );

        // Deselect
        controller.selectLocation(null);
        expect(controller.state.selectedLocationId, isNull);
        expect(controller.state.selectedLocation, isNull);

        // Invalid ID
        controller.selectLocation('non_existent_id');
        expect(controller.state.selectedLocationId, isNull);
      },
    );

    test(
      '7. Marking a location as discovered updates state and calls storage',
      () async {
        final success = await controller.markLocationAsDiscovered(
          'christmas_plaza',
        );
        expect(success, isTrue);
        expect(controller.state.isDiscovered('christmas_plaza'), isTrue);
        expect(controller.state.discoveredCount, equals(1));
        expect(controller.state.progressRatio, equals(1 / locations.length));

        // Verify stored in storage
        final stored = await storage.loadDiscoveredIds();
        expect(stored, contains('christmas_plaza'));
      },
    );

    test('8. Discovering the same location repeatedly is idempotent and does not duplicate', () async {
      await controller.markLocationAsDiscovered('santa_house');
      final firstCount = controller.state.discoveredCount;

      final secondSuccess = await controller.markLocationAsDiscovered(
        'santa_house',
      );
      expect(secondSuccess, isTrue);
      expect(controller.state.discoveredCount, equals(firstCount));

      final stored = await storage.loadDiscoveredIds();
      expect(stored.where((id) => id == 'santa_house').length, equals(1));
    });

    test('9. Discovered count never exceeds total locations count', () async {
      for (final loc in locations) {
        await controller.markLocationAsDiscovered(loc.id);
      }
      expect(controller.state.discoveredCount, equals(locations.length));

      // Attempting to mark invalid or extra IDs
      await controller.markLocationAsDiscovered('extra_invalid_location');
      expect(controller.state.discoveredCount, equals(locations.length));
      expect(controller.state.progressRatio, equals(1.0));
    });

    test(
      '10. init() restores previously saved discovered IDs from storage',
      () async {
        storage = MemoryVillageStorage(
          initialIds: {'christmas_plaza', 'santa_house'},
        );
        final restoringController = VillageController(
          storage: storage,
          locations: locations,
        );

        await restoringController.init();

        expect(restoringController.state.discoveredCount, equals(2));
        expect(
          restoringController.state.isDiscovered('christmas_plaza'),
          isTrue,
        );
        expect(restoringController.state.isDiscovered('santa_house'), isTrue);
        expect(
          restoringController.state.isDiscovered('gift_workshop'),
          isFalse,
        );

        restoringController.dispose();
      },
    );

    test(
      '11. init() safely filters out obsolete or unrecognized IDs',
      () async {
        storage = MemoryVillageStorage(
          initialIds: {'christmas_plaza', 'obsolete_id_from_older_version', ''},
        );
        final restoringController = VillageController(
          storage: storage,
          locations: locations,
        );

        await restoringController.init();

        expect(restoringController.state.discoveredCount, equals(1));
        expect(
          restoringController.state.isDiscovered('christmas_plaza'),
          isTrue,
        );

        restoringController.dispose();
      },
    );

    test(
      '12. isFullyExplored is true when all locations are discovered',
      () async {
        for (final loc in locations) {
          await controller.markLocationAsDiscovered(loc.id);
        }
        expect(controller.state.isFullyExplored, isTrue);
        expect(controller.state.progressRatio, equals(1.0));
      },
    );

    test(
      '13. isFullyExplored is false when any location remains undiscovered',
      () async {
        for (int i = 0; i < locations.length - 1; i++) {
          await controller.markLocationAsDiscovered(locations[i].id);
        }
        expect(controller.state.isFullyExplored, isFalse);
        expect(controller.state.discoveredCount, equals(locations.length - 1));
      },
    );

    test(
      '14. Storage load failure is caught safely and does not crash controller',
      () async {
        storage.shouldFailLoad = true;
        final failController = VillageController(
          storage: storage,
          locations: locations,
        );

        await failController.init();

        expect(failController.state.isLoading, isFalse);
        expect(failController.state.errorMessage, isNotNull);
        expect(failController.state.discoveredCount, equals(0));

        failController.dispose();
      },
    );

    test(
      '15. Storage save failure is handled safely and returns false',
      () async {
        storage.shouldFailSave = true;

        final success = await controller.markLocationAsDiscovered(
          'holiday_bakery',
        );
        expect(success, isFalse);
        expect(controller.state.errorMessage, isNotNull);
        expect(controller.state.isDiscovered('holiday_bakery'), isFalse);
      },
    );

    test('16. markSelectedLocationAsDiscovered works with selection', () async {
      controller.selectLocation('crystal_ice_lake');
      expect(controller.state.isSelectedLocationDiscovered, isFalse);

      final success = await controller.markSelectedLocationAsDiscovered();
      expect(success, isTrue);
      expect(controller.state.isSelectedLocationDiscovered, isTrue);
      expect(controller.state.isDiscovered('crystal_ice_lake'), isTrue);
    });
  });
}
