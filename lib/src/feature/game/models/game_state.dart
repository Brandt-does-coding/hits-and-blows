// The state class
import 'package:hits_and_blows_game/src/feature/game/models/guess.dart';

class GameState {
  final List<int> secretCode;
  final List<Guess> guessHistory;
  final bool gameCompleted;
  final int bestScore;
  final double averageAttempts;
  final int gamesPlayed;
  final int currentDigitIndex; // For navigating between input fields
  final int secretLength;

  GameState({
    required this.secretCode,
    required this.guessHistory,
    required this.gameCompleted,
    required this.bestScore,
    required this.averageAttempts,
    required this.gamesPlayed,
    required this.currentDigitIndex,
    required this.secretLength,
  });

  // Getters
  int get currentAttempt => guessHistory.length + 1;

  // Create a copy with updated values
  GameState copyWith({
    List<int>? secretCode,
    List<Guess>? guessHistory,
    bool? gameCompleted,
    int? bestScore,
    double? averageAttempts,
    int? gamesPlayed,
    int? currentDigitIndex,
    int? secretLength,
  }) {
    return GameState(
      secretCode: secretCode ?? this.secretCode,
      guessHistory: guessHistory ?? this.guessHistory,
      gameCompleted: gameCompleted ?? this.gameCompleted,
      bestScore: bestScore ?? this.bestScore,
      averageAttempts: averageAttempts ?? this.averageAttempts,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      currentDigitIndex: currentDigitIndex ?? this.currentDigitIndex,
      secretLength: secretLength ?? this.secretLength,
    );
  }
}
