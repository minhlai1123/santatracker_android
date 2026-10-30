import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chrimastsatastracker/features/north_pole_village/data/shared_preferences_village_storage.dart';
import 'package:chrimastsatastracker/features/north_pole_village/presentation/controllers/village_controller.dart';

void main() {
  group('SharedPreferencesVillageStorage Persistence Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('Loads empty set when preferences are empty or missing', () async {
      final storage = SharedPreferencesVillageStorage();
      final loaded = await storage.loadDiscoveredIds();
      expect(loaded, isEmpty);
    });

    test('Saves and restores single discovered location', () async {
      final storage = SharedPreferencesVillageStorage();
      final saveResult = await storage.saveDiscoveredIds({'christmas_plaza'});
      expect(saveResult, isTrue);

      final loaded = await storage.loadDiscoveredIds();
      expect(loaded, equals({'christmas_plaza'}));
    });

    test('Saves and restores multiple discovered locations', () async {
      final storage = SharedPreferencesVillageStorage();
      final ids = {
        'christmas_plaza',
        'santa_house',
        'gift_workshop',
        'reindeer_stables',
      };
      final saveResult = await storage.saveDiscoveredIds(ids);
      expect(saveResult, isTrue);

      final loaded = await storage.loadDiscoveredIds();
      expect(loaded, equals(ids));
    });

    test(
      'Safely filters out empty or whitespace-only IDs on save and load',
      () async {
        final storage = SharedPreferencesVillageStorage();
        await storage.saveDiscoveredIds({'christmas_plaza', '', '   '});

        final loaded = await storage.loadDiscoveredIds();
        expect(loaded, equals({'christmas_plaza'}));
      },
    );

    test('Reconstructing VillageController restores persisted data as in app restart', () async {
      // 1. First app session: user discovers two locations
      final storage1 = SharedPreferencesVillageStorage();
      final controller1 = VillageController(storage: storage1);
      await controller1.init();
      expect(controller1.state.discoveredCount, equals(0));

      await controller1.markLocationAsDiscovered('christmas_plaza');
      await controller1.markLocationAsDiscovered('santa_house');
      expect(controller1.state.discoveredCount, equals(2));
      controller1.dispose();

      // 2. Second app session: app restarts, new controller created
      final storage2 = SharedPreferencesVillageStorage();
      final controller2 = VillageController(storage: storage2);
      await controller2.init();

      expect(controller2.state.discoveredCount, equals(2));
      expect(controller2.state.isDiscovered('christmas_plaza'), isTrue);
      expect(controller2.state.isDiscovered('santa_house'), isTrue);
      expect(controller2.state.isDiscovered('gift_workshop'), isFalse);

      controller2.dispose();
    });

    test('Storage handles exceptions gracefully without crashing', () async {
      final failingStorage = SharedPreferencesVillageStorage(
        preferencesProvider: () => Future.error(Exception('Storage error')),
      );

      final loadResult = await failingStorage.loadDiscoveredIds();
      expect(loadResult, isEmpty);

      final saveResult = await failingStorage.saveDiscoveredIds({'test'});
      expect(saveResult, isFalse);
    });
  });
}
