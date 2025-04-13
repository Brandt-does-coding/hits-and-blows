import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hits_and_blows_game/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('verify home screen and instructions popup', (tester) async {
      await tester.pumpWidget(const HitsAndBlowsApp());

      await tester.pumpAndSettle();

      // Verify key UI elements
      expect(find.byKey(Key('app_icon')), findsOneWidget);
      expect(find.text('Hits & Blows'), findsOneWidget);
      expect(find.text('Play'), findsOneWidget);
      expect(find.text('Instructions'), findsOneWidget);

      // Tap 'Instructions' button
      await tester.tap(find.text('Instructions'));
      await tester.pumpAndSettle();

      // Verify bottom sheet popup content
      expect(
        find.textContaining('The game generates a secret'),
        findsWidgets,
      ); // title or description
      expect(
        find.textContaining('You guess the number using the input boxes'),
        findsWidgets,
      ); // from instructions
      expect(
        find.textContaining(
          '🔥 A "Hit" means a correct digit in the correct position.',
        ),
        findsWidgets,
      );
      expect(
        find.textContaining(
          '💥 A "Blow" means a correct digit in the wrong position.',
        ),
        findsWidgets,
      );
      expect(
        find.textContaining(
          'Keep guessing until you get all the digits in the right place!',
        ),
        findsWidgets,
      );
    });
  });
}
