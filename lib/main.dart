import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hits_and_blows_game/src/global/routes/routes.dart';
import 'package:hits_and_blows_game/src/global/themes/theme.dart';

void main() {
  runApp(ProviderScope(child: const HitsAndBlowsApp()));
}

class HitsAndBlowsApp extends StatelessWidget {
  const HitsAndBlowsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hits and Blows',
      theme: AppTheme.darkTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
