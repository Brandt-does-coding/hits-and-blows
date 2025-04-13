import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hits_and_blows_game/main.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pinput/pinput.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets(
      'verify home screen and instructions popup',
      timeout: Timeout(Duration(seconds: 30)),
      skip: true,
      (tester) async {
        await tester.pumpWidget(HitsAndBlowsApp());

        // Verify key UI elements
        expect(find.byKey(ValueKey('app_icon')), findsOneWidget);
        expect(find.text('Hits & Blows'), findsOneWidget);
        expect(find.text('Play'), findsOneWidget);
        expect(find.text('Instructions'), findsOneWidget);

        debugPrint('About to check instructions');
        // Tap 'Instructions' button
        await tester.tap(find.text('Instructions'));
        await tester.pump(Durations.extralong1);
        await tester.pump(Durations.extralong1);

        // Verify bottom sheet popup content
        expect(
          find.textContaining('The game generates a secret'),
          findsWidgets,
        ); // title or description
        await tester.tapAt(Offset.zero);
        await tester.pump(Durations.long1);

        // Now tap Play
        await tester.tap(find.text('Play'));
        await tester.pump(Durations.extralong4);

        // Then you can check if you're on the next screen
        expect(find.text('Easy'), findsOneWidget);
        expect(find.text('Medium'), findsOneWidget);
        expect(find.text('Hard'), findsOneWidget);

        await tester.tap(find.text('Medium'));
        await tester.pump(Durations.medium1);
        await tester.pump(Durations.medium1);
        await tester.pumpAndSettle();

        expect(find.byType(Pinput), findsOneWidget);
      },
    );
  });
}
