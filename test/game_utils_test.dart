import 'package:flutter_test/flutter_test.dart';
import 'package:hits_and_blows_game/src/feature/game/utils/game_utils.dart';

void main() {
  group('GameUtils', () {
    test('generateSecretCode returns unique digits of given length', () {
      final code = GameUtils.generateSecretCode(4);
      expect(code.length, 4);
      expect(code.toSet().length, 4);
    });

    test('calculateHitsAndBlows returns correct values', () {
      final result = GameUtils.calculateHitsAndBlows(
        [1, 2, 3, 4],
        [1, 2, 4, 3],
      );
      expect(result['hits'], 2);
      expect(result['blows'], 2);
    });

    test('getDigitsFromString parses digits correctly', () {
      final digits = GameUtils.getDigitsFromString("1234");
      expect(digits, [1, 2, 3, 4]);
    });

    test('isValidGuess validates correct input', () {
      expect(GameUtils.isValidGuess("1234", 4), null);
      expect(GameUtils.isValidGuess("1123", 4), isNotNull);
      expect(GameUtils.isValidGuess("123", 4), isNotNull);
    });
  });
}
