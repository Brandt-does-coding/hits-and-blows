import 'package:flutter_test/flutter_test.dart';
import 'package:hits_and_blows_game/src/feature/game/providers/game_state_provider.dart';

import 'utils/provider_container_util.dart';

void main() {
  test('initial state has correct secret length and empty history', () {
    final container = createContainer();
    final state = container.read(gameStateProvider);

    expect(state.secretCode.length, state.secretLength);
    expect(state.guessHistory, isEmpty);
    expect(state.gameCompleted, isFalse);
  });

  test('newGame resets history and generates new secret', () {
    final container = createContainer();
    final notifier = container.read(gameStateProvider.notifier);
    final previousSecret = notifier.state.secretCode;

    notifier.submitGuess([1, 2, 3, 4]);
    notifier.newGame();

    final newState = container.read(gameStateProvider);

    expect(newState.guessHistory, isEmpty);
    expect(newState.secretCode, isNot(equals(previousSecret)));
  });

  test('submitGuess adds to history and sets gameCompleted when correct', () {
    final container = createContainer();
    final notifier = container.read(gameStateProvider.notifier);

    // overwrite secret for test predictability
    final correct = [1, 2, 3, 4];
    notifier.state = notifier.state.copyWith(secretCode: correct);

    final guess = notifier.submitGuess(correct);
    final state = container.read(gameStateProvider);

    expect(state.guessHistory.length, 1);
    expect(guess?.hits, correct.length);
    expect(guess?.blows, 0);
    expect(state.gameCompleted, isTrue);
  });

  test('revealCode sets gameCompleted to true', () {
    final container = createContainer();
    final notifier = container.read(gameStateProvider.notifier);

    expect(notifier.state.gameCompleted, isFalse);

    notifier.revealCode();

    expect(notifier.state.gameCompleted, isTrue);
  });
  test('new game with custom secret length has new length', () {
    final container = createContainer();
    final notifier = container.read(gameStateProvider.notifier);

    notifier.newGame(5);

    expect(notifier.secretLength, 5);
  });

  test('current attemps is correct', () {
    final container = createContainer();
    final notifier = container.read(gameStateProvider.notifier);

    // overwrite secret for test predictability
    final correct = [1, 2, 3, 4];
    final incorrect = [4, 2, 3, 1];
    notifier.state = notifier.state.copyWith(secretCode: correct);

    final guess = notifier.submitGuess(incorrect);

    expect(guess?.attemptNumber, 1);
    expect(guess?.hits, 2);
    expect(guess?.blows, 2);

    final correctGuess = notifier.submitGuess(correct);
    expect(correctGuess?.attemptNumber, 2);
    expect(correctGuess?.isCorrect, true);
  });
}
