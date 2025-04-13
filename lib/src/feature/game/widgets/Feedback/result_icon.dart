import 'package:flutter/material.dart';

class ResultIcon extends StatelessWidget {
  const ResultIcon({
    super.key,
    required this.iconText,
    required this.valueText,
    required this.textColor,
    required this.iconSize,
  });

  final String iconText;
  final String valueText;
  final Color textColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(iconText, style: TextStyle(fontSize: iconSize)),
        Text(
          valueText,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
