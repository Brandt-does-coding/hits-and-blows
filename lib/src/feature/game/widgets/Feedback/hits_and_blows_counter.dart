import 'package:flutter/material.dart';
import 'package:hits_and_blows_game/src/global/themes/theme.dart';
import 'package:hits_and_blows_game/src/feature/game/widgets/Feedback/result_icon.dart';

class HitsAndBlowsCounter extends StatelessWidget {
  const HitsAndBlowsCounter({
    super.key,
    required this.hitsText,
    required this.blowsText,
    required this.iconSize,
  });

  final String hitsText;
  final String blowsText;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if horizontal space is sufficient
        bool shouldStack =
            constraints.maxWidth < 100; // Adjust threshold as needed
        if (shouldStack) {
          // Stack vertically if horizontal space is small
          return Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 6.0,
            children: [
              ResultIcon(
                iconText: '🔥',
                valueText: hitsText,
                textColor: AppTheme.hitcolor,
                iconSize: iconSize,
              ),
              ResultIcon(
                iconText: '💥',
                valueText: blowsText,
                textColor: AppTheme.blowColor,
                iconSize: iconSize,
              ),
            ],
          );
        } else {
          // Otherwise, display horizontally in a row
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12.0,
            children: [
              ResultIcon(
                iconText: '🔥',
                valueText: hitsText,
                textColor: AppTheme.hitcolor,
                iconSize: iconSize,
              ),
              ResultIcon(
                iconText: '💥',
                valueText: blowsText,
                textColor: AppTheme.blowColor,
                iconSize: iconSize,
              ),
            ],
          );
        }
      },
    );
  }
}
