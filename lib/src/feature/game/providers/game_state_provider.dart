import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hits_and_blows_game/src/feature/game/utils/game_utils.dart';
import 'package:hits_and_blows_game/src/feature/game/models/game_state.dart';
import 'package:hits_and_blows_game/src/feature/game/models/guess.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          bestScore: 0,
          averageAttempts: 0.0,
          gamesPlayed: 0,
          currentDigitIndex: 0,
          secretLength: 4,
        ),
      ) {
    _initGame(4);
    _loadStats();
  }

  // Initialize a new game
  void _initGame(int length) {
    state = state.copyWith(
      secretCode: GameUtils.generateSecretCode(length),
      guessHistory: [],
      gameCompleted: false,
      currentDigitIndex: 0,
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
  void newGame(int length) {
    _initGame(length);
  }

  // Load statistics from shared preferences
  Future<void> _loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    state = state.copyWith(
      bestScore: prefs.getInt('bestScore') ?? 0,
      averageAttempts: prefs.getDouble('averageAttempts') ?? 0.0,
      gamesPlayed: prefs.getInt('gamesPlayed') ?? 0,
    );
  }

  // Save statistics to shared preferences
  Future<void> _saveStats() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('bestScore', state.bestScore);
    await prefs.setDouble('averageAttempts', state.averageAttempts);
    await prefs.setInt('gamesPlayed', state.gamesPlayed);
  }

  // Update current digit index (for input field navigation)
  void updateCurrentDigitIndex(int index) {
    state = state.copyWith(currentDigitIndex: index);
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

    // Update stats if game is won
    if (isGameWon) {
      _updateStatsOnWin(
        state.currentAttempt - 1,
      ); // -1 because we already added the guess
    }
    return newGuess;
  }

  // Update statistics when game is won
  void _updateStatsOnWin(int attempts) {
    final newGamesPlayed = state.gamesPlayed + 1;
    int newBestScore = state.bestScore;
    double newAverageAttempts = state.averageAttempts;

    // Update best score
    if (state.bestScore == 0 || attempts < state.bestScore) {
      newBestScore = attempts;
    }

    // Update average attempts
    if (newGamesPlayed == 1) {
      newAverageAttempts = attempts.toDouble();
    } else {
      // Recalculate average
      newAverageAttempts =
          (state.averageAttempts * (newGamesPlayed - 1) + attempts) /
          newGamesPlayed;
    }

    state = state.copyWith(
      gamesPlayed: newGamesPlayed,
      bestScore: newBestScore,
      averageAttempts: newAverageAttempts,
    );

    _saveStats();
  }

  // Reveal the secret code (for giving up)
  void revealCode() {
    if (!state.gameCompleted) {
      state = state.copyWith(gameCompleted: true);
    }
  }
}
