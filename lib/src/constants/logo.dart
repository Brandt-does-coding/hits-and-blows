import 'package:flutter/material.dart';
import 'package:hits_and_blows_game/src/global/themes/theme.dart';

const appLogo = Hero(
  tag: 'logo',
  child: Material(
    type: MaterialType.transparency,
    child: DefaultTextStyle(
      style: AppTheme.mainTitleStyle,
      child: Text('Hits & Blows'),
    ),
  ),
);
