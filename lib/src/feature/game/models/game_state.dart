// The state class
import 'package:hits_and_blows_game/src/feature/game/models/guess.dart';

class GameState {
  final List<int> secretCode;
  final List<Guess> guessHistory;
  final bool gameCompleted;
  final int gamesPlayed;
  final int secretLength;
  final List<int> currentGuess;

  GameState({
    required this.secretCode,
    required this.guessHistory,
    required this.gameCompleted,
    required this.gamesPlayed,
    required this.secretLength,
    required this.currentGuess,
  });

  // Getters
  int get currentAttempt => guessHistory.length + 1;

  // Create a copy with updated values
  GameState copyWith({
    List<int>? secretCode,
    List<Guess>? guessHistory,
    bool? gameCompleted,
    int? gamesPlayed,
    int? secretLength,
    List<int>? currentGuess,
  }) {
    return GameState(
      secretCode: secretCode ?? this.secretCode,
      guessHistory: guessHistory ?? this.guessHistory,
      gameCompleted: gameCompleted ?? this.gameCompleted,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      secretLength: secretLength ?? this.secretLength,
      currentGuess: currentGuess ?? this.currentGuess,
    );
  }
}
