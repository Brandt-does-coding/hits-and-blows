import 'package:flutter/material.dart';

final kAppLogo = Hero(
  tag: 'logo',
  key: Key('app_icon'),
  child: SizedBox(
    height: 32,
    child: Image.asset(
      'assets/images/icon_min.png',
      fit: BoxFit.contain, // or .cover, .fill, etc.
    ),
  ),
);
