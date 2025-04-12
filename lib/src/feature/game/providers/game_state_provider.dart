import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hits_and_blows_game/src/feature/game/utils/game_utils.dart';
import 'package:hits_and_blows_game/src/feature/game/models/game_state.dart';
import 'package:hits_and_blows_game/src/feature/game/models/guess.dart';

// Create a provider for the GameState
final gameStateProvider = StateNotifierProvider<GameStateNotifier, GameState>((
  ref,
) {
  return GameStateNotifier();
});

// The state notifier
class GameStateNotifier extends StateNotifier<GameState> {
  GameStateNotifier()
    : super(
        GameState(
          secretCode: [],
          guessHistory: [],
          gameCompleted: false,
          gamesPlayed: 0,
          currentGuess: [],
          secretLength: 4,
        ),
      ) {
    _initGame(4);
  }

  // Initialize a new game
  void _initGame(int length) {
    state = state.copyWith(
      secretCode: GameUtils.generateSecretCode(length),
      guessHistory: [],
      gameCompleted: false,
      currentGuess: [],
      secretLength: length,
    );

    if (kDebugMode) {
      print('Secret code: ${state.secretCode.join()}');
    }
  }

  void updateSecrectLength(int length) {
    _initGame(length);
  }

  int get secretLength => state.secretLength;

  // Start a new game
  void newGame([int? length]) {
    //restart at same length as previous game
    if (length == null) {
      _initGame(secretLength);
      return;
    }
    _initGame(length);
  }

  // Submit a guess
  Guess? submitGuess(List<int> digits) {
    if (state.gameCompleted) return null;

    // Calculate hits and blows
    final result = GameUtils.calculateHitsAndBlows(state.secretCode, digits);
    final hits = result['hits']!;
    final blows = result['blows']!;

    // Create and add the new guess
    final newGuess = Guess(
      digits: List.from(digits),
      hits: hits,
      blows: blows,
      attemptNumber: state.currentAttempt,
      secretLength: state.secretLength,
    );

    // Add to history
    final updatedHistory = [...state.guessHistory, newGuess];

    // Check if the game is won
    final isGameWon = hits == state.secretLength;

    // Update state
    state = state.copyWith(
      guessHistory: updatedHistory,
      gameCompleted: isGameWon,
    );

    return newGuess;
  }

  // Reveal the secret code (for giving up)
  void revealCode() {
    if (!state.gameCompleted) {
      state = state.copyWith(gameCompleted: true);
    }
  }
}
