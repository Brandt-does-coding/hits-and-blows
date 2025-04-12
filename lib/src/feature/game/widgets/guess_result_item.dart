import 'package:flutter/material.dart';
import 'package:hits_and_blows_game/src/feature/game/models/guess.dart';
import 'package:hits_and_blows_game/src/global/themes/theme.dart';
import 'package:hits_and_blows_game/src/feature/game/widgets/hits_and_blows_counter.dart';

class GuessResultItem extends StatelessWidget {
  final Guess guess;
  final bool isLatest;

  const GuessResultItem({
    super.key,
    required this.guess,
    this.isLatest = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow:
            isLatest
                ? [
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
                : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        border:
            isLatest
                ? Border.all(color: AppTheme.primaryColor, width: 2)
                : null,
      ),
      child: Row(
        children: [
          // Attempt number
          // Container(
          //   width: 30,
          //   height: 30,
          //   alignment: Alignment.center,
          //   decoration: BoxDecoration(
          //     color: isLatest ? AppTheme.primaryColor : Colors.grey.shade200,
          //     shape: BoxShape.circle,
          //   ),
          //   child: Text(
          //     '${guess.attemptNumber}',
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       color: isLatest ? Colors.white : Colors.black,
          //       fontSize: 14,
          //     ),
          //   ),
          // ),
          // const SizedBox(width: 12),

          // Guess digits
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:
                  guess.digits.map((digit) {
                    return Container(
                      width: 36,
                      height: 36,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$digit',
                        style: AppTheme.inputTextStyle.copyWith(fontSize: 18),
                      ),
                    );
                  }).toList(),
            ),
          ),
          HitsAndBlowsCounter(
            hitsText: '${guess.hits}',
            blowsText: '${guess.blows}',
            iconSize: 24,
          ),
        ],
      ),
    );
  }
}
