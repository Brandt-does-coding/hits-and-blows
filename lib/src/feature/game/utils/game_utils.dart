import 'dart:math';

class GameUtils {
  // Generate a random 4-digit code with unique digits
  static List<int> generateSecretCode(int length) {
    final random = Random();
    final List<int> available = List.generate(10, (i) => i); // 0-9
    final List<int> code = [];

    // Select 4 unique random digits
    for (int i = 0; i < length; i++) {
      final index = random.nextInt(available.length);
      code.add(available[index]);
      available.removeAt(index);
    }

    return code;
  }

  // Calculate hits and blows for a guess
  static Map<String, int> calculateHitsAndBlows(
    List<int> secretCode,
    List<int> guess,
  ) {
    int hits = 0;
    int blows = 0;

    for (int i = 0; i < secretCode.length; i++) {
      if (secretCode[i] == guess[i]) {
        hits++;
      }
    }
    // Count total matches to derive blows
    int totalMatches = 0;

    for (var digit in guess) {
      if (secretCode.contains(digit)) {
        totalMatches++;
      }
    }
    // Cows = total matches - hits
    blows = totalMatches - hits;

    return {'hits': hits, 'blows': blows};
  }

  static List<int> getDigitsFromString(String input) {
    return input.split('').map(int.parse).toList();
  }

  // Validate a guess
  static String? isValidGuess(String? input, int length) {
    if (input == null) {
      return "Please enter $length unique digits";
    }
    final digits = getDigitsFromString(input);

    if (digits.length != length) {
      return "Please enter $length digits";
    }

    // Convert to non-nullable list
    final nonNullDigits = digits.map((d) => d).toList();

    // Check for duplicates (optional based on game rules)
    final uniqueDigits = nonNullDigits.toSet().length;
    return uniqueDigits == nonNullDigits.length
        ? null
        : "Please enter $length unique digits";
  }
}
