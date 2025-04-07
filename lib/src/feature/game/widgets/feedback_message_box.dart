import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hits_and_blows_game/src/feature/game/providers/game_state_provider.dart';
import 'package:hits_and_blows_game/src/global/themes/theme.dart';

class FeedbackMessageBox extends ConsumerWidget {
  final bool showInvalidInputMessage;
  final String? feedbackMessage;
  const FeedbackMessageBox(
    this.showInvalidInputMessage,
    this.feedbackMessage, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);
    final guessHistory = gameState.guessHistory;
    final isGameCompleted = gameState.gameCompleted;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color:
            showInvalidInputMessage
                ? AppTheme.wrongColor.withValues(alpha: 0.1)
                : isGameCompleted &&
                    guessHistory.isNotEmpty &&
                    guessHistory.last.isCorrect
                ? AppTheme.correctColor.withValues(alpha: 0.1)
                : AppTheme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        feedbackMessage!,
        style: TextStyle(
          color:
              showInvalidInputMessage
                  ? AppTheme.wrongColor
                  : isGameCompleted &&
                      guessHistory.isNotEmpty &&
                      guessHistory.last.isCorrect
                  ? AppTheme.correctColor
                  : AppTheme.primaryColor,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
