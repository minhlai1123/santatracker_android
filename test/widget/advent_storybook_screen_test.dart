import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/core/constants/app_strings.dart';
import 'package:chrimastsatastracker/core/theme/app_theme.dart';
import 'package:chrimastsatastracker/features/advent_storybook/data/memory_advent_storage.dart';
import 'package:chrimastsatastracker/features/advent_storybook/presentation/controllers/advent_storybook_controller.dart';
import 'package:chrimastsatastracker/features/advent_storybook/presentation/screens/advent_storybook_screen.dart';
import 'package:chrimastsatastracker/features/mini_games/data/memory_mini_games_storage.dart';
import 'package:chrimastsatastracker/features/mini_games/presentation/controllers/mini_games_controller.dart';

void main() {
  Widget buildTestableStorybook({AdventStorybookController? controller}) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: AdventStorybookScreen(controller: controller),
    );
  }

  group('AdventStorybookScreen Widget & Responsive Tests', () {
    testWidgets('1. Renders storybook header, progress, and 24 chapter cards', (
      WidgetTester tester,
    ) async {
      final adventStorage = MemoryAdventStorage();
      final gamesStorage = MemoryMiniGamesStorage();
      final gamesController = MiniGamesController(storage: gamesStorage);
      await gamesController.initialize();

      final controller = AdventStorybookController(
        storage: adventStorage,
        gamesController: gamesController,
      );
      await controller.initialize();

      await tester.pumpWidget(buildTestableStorybook(controller: controller));
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.adventScreenTitle), findsAtLeastNWidgets(1));
      expect(find.text(AppStrings.adventSubtitle), findsOneWidget);

      // Dual progress meters
      expect(find.text(AppStrings.adventUnlockedCountLabel), findsOneWidget);
      expect(find.text(AppStrings.adventReadCountLabel), findsOneWidget);
      expect(find.text('1 / 24'), findsOneWidget);
      expect(find.text('0 / 24'), findsOneWidget);

      // Chapter 1 is unlocked
      expect(find.byKey(const Key('chapter_card_1')), findsOneWidget);
      expect(
        find.text('${AppStrings.adventDayPrefix} 1: The First Gift'),
        findsOneWidget,
      );
      expect(find.text(AppStrings.adventStatusUnlocked), findsOneWidget);

      // Chapter 2 is locked
      expect(find.byKey(const Key('chapter_card_2')), findsOneWidget);
      expect(find.text(AppStrings.adventStatusLocked), findsAtLeastNWidgets(1));
    });

    testWidgets('2. Tapping locked chapter displays condition in SnackBar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(buildTestableStorybook());
      await tester.pumpAndSettle();

      // Tap locked chapter 2
      final card2 = find.byKey(const Key('chapter_card_2'));
      await tester.ensureVisible(card2);
      await tester.tap(card2);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(SnackBar),
          matching: find.textContaining('Win the Holiday Memory Match'),
        ),
        findsOneWidget,
      );
    });

    testWidgets(
      '3. Tapping unlocked chapter opens reader and updates read status',
      (WidgetTester tester) async {
        final adventStorage = MemoryAdventStorage();
        final gamesStorage = MemoryMiniGamesStorage();
        final gamesController = MiniGamesController(storage: gamesStorage);
        await gamesController.initialize();

        final controller = AdventStorybookController(
          storage: adventStorage,
          gamesController: gamesController,
        );
        await controller.initialize();

        await tester.pumpWidget(buildTestableStorybook(controller: controller));
        await tester.pumpAndSettle();

        // Tap unlocked chapter 1
        final card1 = find.byKey(const Key('chapter_card_1'));
        await tester.ensureVisible(card1);
        await tester.tap(card1);
        await tester.pumpAndSettle();

        // Verify on AdventChapterReaderScreen
        expect(find.text('The First Gift'), findsOneWidget);
        expect(find.text(AppStrings.festiveMessageTitle), findsOneWidget);
        expect(find.text(AppStrings.activityPromptTitle), findsOneWidget);

        // Verify mark as read button
        final markReadBtn = find.byKey(const Key('btn_mark_as_read'));
        expect(markReadBtn, findsOneWidget);
        await tester.ensureVisible(markReadBtn);
        await tester.tap(markReadBtn);
        await tester.pumpAndSettle();

        // Tap back button
        final backBtn = find.byKey(const Key('btn_back_to_storybook'));
        expect(backBtn, findsOneWidget);
        await tester.ensureVisible(backBtn);
        await tester.tap(backBtn);
        await tester.pumpAndSettle();

        // Verify controller state
        expect(controller.state.readChapterDays.contains(1), isTrue);
        expect(controller.state.readCount, 1);

        // Back on storybook: scroll to top and check read count updated to 1 / 24
        await tester.drag(find.byType(ListView), const Offset(0, 500));
        await tester.pumpAndSettle();

        expect(find.text('1 / 24'), findsAtLeastNWidgets(1));

        await tester.ensureVisible(card1);
        expect(
          find.descendant(
            of: card1,
            matching: find.text(AppStrings.adventStatusRead),
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets('4. Responsive check on small phone (360x640)', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestableStorybook());
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.adventScreenTitle), findsAtLeastNWidgets(1));
      expect(tester.takeException(), isNull);
    });

    testWidgets('5. Responsive check on standard phone (390x844)', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestableStorybook());
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.adventScreenTitle), findsAtLeastNWidgets(1));
      expect(tester.takeException(), isNull);
    });

    testWidgets('6. Responsive check on tablet screen (768x1024)', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(768, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestableStorybook());
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.adventScreenTitle), findsAtLeastNWidgets(1));
      expect(tester.takeException(), isNull);
    });
  });
}
