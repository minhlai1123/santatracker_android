import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrimastsatastracker/shared/widgets/christmas_card.dart';
import 'package:chrimastsatastracker/shared/widgets/christmas_tree_decoration.dart';
import 'package:chrimastsatastracker/shared/widgets/snowfall_overlay.dart';

void main() {
  group('Shared Festive Components Widget Tests', () {
    testWidgets(
      'SnowfallOverlay renders child and permits child touch interactions',
      (WidgetTester tester) async {
        int tapCount = 0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SnowfallOverlay(
                numberOfSnowflakes: 15,
                child: ElevatedButton(
                  onPressed: () {
                    tapCount++;
                  },
                  child: const Text('Test Button'),
                ),
              ),
            ),
          ),
        );

        expect(find.text('Test Button'), findsOneWidget);
        await tester.tap(find.text('Test Button'));
        await tester.pump();

        expect(tapCount, equals(1));
      },
    );

    testWidgets('ChristmasTreeDecoration paints without exceptions', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ChristmasTreeDecoration(width: 80, height: 100)),
        ),
      );

      expect(find.byType(ChristmasTreeDecoration), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('ChristmasCard renders child with festive styling', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: ChristmasCard(child: Text('Festive Content'))),
        ),
      );

      expect(find.text('Festive Content'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
