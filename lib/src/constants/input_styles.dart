import 'package:flutter/material.dart';
import 'package:hits_and_blows_game/src/global/themes/theme.dart';

final InputDecoration inputDecoration = InputDecoration(
  counterStyle: TextStyle(height: double.minPositive),
  counterText: '',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: AppTheme.inputBorderColor, width: 1.5),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: AppTheme.primaryColor, width: 2.0),
  ),
  filled: true,
);
