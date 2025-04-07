import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hits_and_blows_game/src/constants/button_styles.dart';
import 'package:hits_and_blows_game/src/feature/game/providers/game_state_provider.dart';
import 'package:hits_and_blows_game/src/global/themes/theme.dart';
import 'package:hits_and_blows_game/src/global/widgets/buttons.dart';

class ModeSelectScreen extends ConsumerWidget {
  const ModeSelectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'logo',
          child: Material(
            type: MaterialType.transparency,
            child: DefaultTextStyle(
              style: AppTheme.mainTitleStyle,
              child: Text('Hits & Blows'),
            ),
          ),
        ),
        backgroundColor: AppTheme.darkBackgroundColor,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.chevron_left),
        ),
      ),
      backgroundColor: AppTheme.darkBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 30.0,
          children: [
            AnimatedButton(
              onPressed: () {
                ref.read(gameStateProvider.notifier).newGame(2);
                context.go('/game');
              },
              text: 'Easy',
              style: EasyStyle(),
            ),
            AnimatedButton(
              onPressed: () {
                ref.read(gameStateProvider.notifier).newGame(4);
                context.go('/game');
              },
              text: 'Medium',
              style: MediumStyle(),
            ),
            AnimatedButton(
              onPressed: () {
                ref.read(gameStateProvider.notifier).newGame(5);
                context.go('/game');
              },
              text: 'Hard',
              style: HardStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
