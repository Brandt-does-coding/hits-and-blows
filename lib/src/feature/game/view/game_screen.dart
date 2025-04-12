import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hits_and_blows_game/src/constants/button_styles.dart';
import 'package:hits_and_blows_game/src/constants/logo.dart';
import 'package:hits_and_blows_game/src/feature/game/providers/input_provider.dart';
import 'package:hits_and_blows_game/src/feature/game/widgets/history_list.dart';
import 'package:hits_and_blows_game/src/feature/game/widgets/number_inputs.dart';
import 'package:hits_and_blows_game/src/feature/game/providers/game_state_provider.dart';
import 'package:hits_and_blows_game/src/global/themes/theme.dart';
import 'package:hits_and_blows_game/src/feature/game/widgets/secret_code_reveal.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: kAppLogo,
          backgroundColor: Colors.blueGrey[900],
          leading: IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: Icon(Icons.home),
          ),
        ),

        backgroundColor: AppTheme.darkBackgroundColor,
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20.0,
            children: [
              if (!gameState.gameCompleted) NumberInputs(),
              if (gameState.gameCompleted) SecretCodeReveal(),
              if (!gameState.gameCompleted)
                ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle),
                  onPressed:
                      () =>
                          ref
                              .read(singleInputProvider)
                              .formKey
                              .currentState
                              ?.validate(),
                  label: const Text('Submit Guess'),
                  style: MainStyle(),
                ),
              if (gameState.gameCompleted)
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  onPressed:
                      () => ref.read(gameStateProvider.notifier).newGame(),
                  label: const Text('New Game'),
                  style: MainStyle(),
                ),
              if (gameState.gameCompleted)
                Text(
                  "Attempts: ${gameState.currentAttempt}",
                  style: AppTheme.mainTitleStyle.copyWith(fontSize: 20.0),
                ),
              Expanded(child: HistoryList()),
            ],
          ),
        ),
      ),
    );
  }
}
