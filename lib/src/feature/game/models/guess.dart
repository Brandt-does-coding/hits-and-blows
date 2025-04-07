class Guess {
  final List<int> digits;
  final int hits; // Correct digit in correct position
  final int blows; // Correct digit in wrong position
  final int attemptNumber;
  final int secretLength;

  Guess({
    required this.digits,
    required this.hits,
    required this.blows,
    required this.attemptNumber,
    required this.secretLength,
  });

  // Check if this guess is correct (all hits)
  bool get isCorrect => hits == secretLength;

  // Convert to string representation
  String get digitsAsString => digits.join('');

  // Create a copy with updated values
  Guess copyWith({
    List<int>? digits,
    int? hits,
    int? blows,
    int? attemptNumber,
    int? secretLength,
  }) {
    return Guess(
      digits: digits ?? this.digits,
      hits: hits ?? this.hits,
      blows: blows ?? this.blows,
      attemptNumber: attemptNumber ?? this.attemptNumber,
      secretLength: secretLength ?? this.secretLength,
    );
  }

  // For storing in shared preferences
  Map<String, dynamic> toJson() {
    return {
      'digits': digits,
      'hits': hits,
      'blows': blows,
      'attemptNumber': attemptNumber,
      'secretLength': secretLength,
    };
  }

  // Create from stored JSON
  factory Guess.fromJson(Map<String, dynamic> json) {
    return Guess(
      digits: List<int>.from(json['digits']),
      hits: json['hits'],
      blows: json['blows'],
      attemptNumber: json['attemptNumber'],
      secretLength: json['secretLength'],
    );
  }
}
