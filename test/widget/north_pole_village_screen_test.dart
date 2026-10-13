import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/core/constants/app_strings.dart';
import 'package:chrimastsatastracker/core/theme/app_theme.dart';
import 'package:chrimastsatastracker/features/home/presentation/screens/home_screen.dart';
import 'package:chrimastsatastracker/features/north_pole_village/data/memory_village_storage.dart';
import 'package:chrimastsatastracker/features/north_pole_village/domain/services/north_pole_village_data.dart';
import 'package:chrimastsatastracker/features/north_pole_village/presentation/controllers/village_controller.dart';
import 'package:chrimastsatastracker/features/north_pole_village/presentation/screens/north_pole_village_screen.dart';

void main() {
  Widget buildVillageTestApp({VillageController? controller}) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: NorthPoleVillageScreen(
        controller:
            controller ?? VillageController(storage: MemoryVillageStorage()),
      ),
    );
  }

  group('NorthPoleVillageScreen Widget & Responsive Tests', () {
    const locations = NorthPoleVillageData.defaultLocations;

    testWidgets(
      '1-3. Renders screen title, progress header, illustrated village map, and all 8 location markers',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildVillageTestApp());
        await tester.pumpAndSettle();

        // 1. Title
        expect(
          find.text(AppStrings.villageScreenTitle),
          findsAtLeastNWidgets(1),
        );

        // 2. Village map container and canvas
        expect(find.byKey(const Key('village_map_container')), findsOneWidget);
        expect(find.byKey(const Key('village_map_canvas')), findsOneWidget);

        // 3. All 8 location markers present
        for (final loc in locations) {
          expect(find.byKey(Key('village_marker_${loc.id}')), findsOneWidget);
        }

        // Initial hint card when no location is selected
        expect(find.byKey(const Key('village_hint_card')), findsOneWidget);
        expect(find.text(AppStrings.selectLocationHint), findsOneWidget);
        expect(find.textContaining('0 / 8 địa điểm'), findsOneWidget);
      },
    );

    testWidgets(
      '4-6. Tapping a location marker displays detail sheet, and close button dismisses it',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildVillageTestApp());
        await tester.pumpAndSettle();

        // 4. Tap marker for christmas_plaza
        final plazaMarker = find.byKey(
          const Key('village_marker_christmas_plaza'),
        );
        await tester.ensureVisible(plazaMarker);
        await tester.tap(plazaMarker);
        await tester.pumpAndSettle();

        // 5. Detail sheet displayed
        expect(
          find.byKey(const Key('village_location_detail_sheet')),
          findsOneWidget,
        );
        expect(find.text('Quảng Trường Lễ Hội'), findsAtLeastNWidgets(1));
        expect(
          find.byKey(const Key('badge_location_undiscovered')),
          findsOneWidget,
        );
        expect(find.byKey(const Key('btn_discover_location')), findsOneWidget);

        // 6. Tap close button
        final closeBtn = find.byKey(const Key('btn_close_location_sheet'));
        await tester.ensureVisible(closeBtn);
        await tester.tap(closeBtn);
        await tester.pumpAndSettle();

        // Hint card restored
        expect(find.byKey(const Key('village_hint_card')), findsOneWidget);
        expect(
          find.byKey(const Key('village_location_detail_sheet')),
          findsNothing,
        );
      },
    );

    testWidgets(
      '7-10. Tapping discover updates location status, checkmark badge, and progress counter',
      (WidgetTester tester) async {
        final storage = MemoryVillageStorage();
        final controller = VillageController(storage: storage);

        await tester.pumpWidget(buildVillageTestApp(controller: controller));
        await tester.pumpAndSettle();

        // Select santa_house
        final marker = find.byKey(const Key('village_marker_santa_house'));
        await tester.ensureVisible(marker);
        await tester.tap(marker);
        await tester.pumpAndSettle();

        expect(find.textContaining('0 / 8 địa điểm'), findsOneWidget);

        // 7. Tap "Khám Phá Địa Điểm Này"
        final discoverBtn = find.byKey(const Key('btn_discover_location'));
        await tester.ensureVisible(discoverBtn);
        await tester.tap(discoverBtn);
        await tester.pumpAndSettle();

        // 8-10. Status becomes discovered, progress is 1/8
        expect(
          find.byKey(const Key('badge_location_discovered')),
          findsOneWidget,
        );
        expect(find.textContaining('1 / 8 địa điểm'), findsOneWidget);
        expect(controller.state.isDiscovered('santa_house'), isTrue);

        controller.dispose();
      },
    );

    testWidgets(
      '11. Discovering all 8 locations displays completion banner and 100% progress',
      (WidgetTester tester) async {
        final storage = MemoryVillageStorage();
        final controller = VillageController(storage: storage);

        await tester.pumpWidget(buildVillageTestApp(controller: controller));
        await tester.pumpAndSettle();

        // Discover all locations
        for (final loc in locations) {
          await controller.markLocationAsDiscovered(loc.id);
        }
        await tester.pumpAndSettle();

        // Verify completion banner
        expect(
          find.byKey(const Key('village_completed_banner')),
          findsOneWidget,
        );
        expect(find.text(AppStrings.villageCompletedBanner), findsOneWidget);
        expect(find.textContaining('8 / 8 địa điểm'), findsOneWidget);
        expect(find.text('100%'), findsOneWidget);

        controller.dispose();
      },
    );

    testWidgets(
      '12-15. Navigation between HomeScreen and NorthPoleVillageScreen works and preserves other features',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.lightTheme,
            home: HomeScreen(clock: () => DateTime(2026, 12, 15, 10, 0, 0)),
          ),
        );
        await tester.pumpAndSettle();

        // 14. Santa Tracker card is active
        expect(
          find.byKey(const Key('home_santa_tracker_card')),
          findsOneWidget,
        );

        // 15. Only 2 remaining features in Coming Soon
        expect(find.text(AppStrings.gamesFeatureTitle), findsOneWidget);
        expect(find.text(AppStrings.adventFeatureTitle), findsOneWidget);
        expect(find.text(AppStrings.comingSoonBadge), findsNWidgets(2));

        // 12. Open North Pole Village
        final openVillageBtn = find.byKey(const Key('btn_open_village'));
        await tester.ensureVisible(openVillageBtn);
        await tester.tap(openVillageBtn);
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('village_map_container')), findsOneWidget);

        // 13. Back to Home
        final backBtn = find.text(AppStrings.backToHomeButton);
        await tester.ensureVisible(backBtn);
        await tester.tap(backBtn);
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('home_village_card')), findsOneWidget);
      },
    );

    testWidgets(
      '17a. Responsive check on small phone screen (360x640) has zero overflow',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(360, 640);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(buildVillageTestApp());
        await tester.pumpAndSettle();

        // Select a location to test detail sheet on small screen
        final marker = find.byKey(const Key('village_marker_christmas_plaza'));
        await tester.ensureVisible(marker);
        await tester.tap(marker);
        await tester.pumpAndSettle();

        expect(
          find.byKey(const Key('village_location_detail_sheet')),
          findsOneWidget,
        );
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      '17b. Responsive check on standard phone screen (390x844) has zero overflow',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(buildVillageTestApp());
        await tester.pumpAndSettle();

        final marker = find.byKey(const Key('village_marker_santa_house'));
        await tester.ensureVisible(marker);
        await tester.tap(marker);
        await tester.pumpAndSettle();

        expect(
          find.byKey(const Key('village_location_detail_sheet')),
          findsOneWidget,
        );
        expect(tester.takeException(), isNull);
      },
    );

    testWidgets(
      '17c. Responsive check on tablet screen (768x1024) has zero overflow',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(768, 1024);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() {
          tester.view.resetPhysicalSize();
          tester.view.resetDevicePixelRatio();
        });

        await tester.pumpWidget(buildVillageTestApp());
        await tester.pumpAndSettle();

        expect(find.byKey(const Key('village_map_container')), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  });
}
