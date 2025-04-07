import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hits_and_blows_game/src/feature/home/view/home_screen.dart';
import 'package:hits_and_blows_game/src/feature/instructions/view/instructions_screen.dart';

void main() {
  testWidgets('HomeScreen displays title and buttons', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: GoRouter(
          routes: [
            GoRoute(path: '/', builder: (context, state) => HomeScreen()),
          ],
        ),
      ),
    );

    expect(find.text('Hits & Blows'), findsOneWidget);
    expect(find.text('Play'), findsOneWidget);
    expect(find.text('Instructions'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
  });

  testWidgets('InstructionsScreen displays rules and back button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MaterialApp(home: InstructionsScreen()));

    expect(find.text('How to Play'), findsOneWidget);
    expect(find.textContaining('Hits & Blows Rules:'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
  });
}
