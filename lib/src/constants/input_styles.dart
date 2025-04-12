import 'package:flutter/material.dart';
import 'package:hits_and_blows_game/src/global/themes/theme.dart';
import 'package:pinput/pinput.dart';

final InputDecoration kInputDecoration = InputDecoration(
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

final kDefaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
    fontSize: 22,
    color: Color.fromRGBO(30, 60, 87, 1),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(19),
    color: Colors.white,
  ),
);

final kSubmitPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(fontSize: 22, color: AppTheme.correctColor),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(19),
    color: Colors.white38,
  ),
);
