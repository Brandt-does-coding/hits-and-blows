import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hits_and_blows_game/src/feature/game/view/game_screen.dart';
import 'package:hits_and_blows_game/src/feature/home/view/home_screen.dart';
import 'package:hits_and_blows_game/src/feature/instructions/view/instructions_screen.dart';
import 'package:hits_and_blows_game/src/feature/game/view/mode_select_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder:
          (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              // Only apply transition on reverse navigation (back)
              if (animation.status == AnimationStatus.reverse) {
                const begin = Offset(-1.0, 0.0); // from left
                const end = Offset.zero;
                const curve = Curves.easeOut;

                var tween = Tween(
                  begin: begin,
                  end: end,
                ).chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              }

              // No transition on forward navigation (app start)
              return child;
            },
          ),
    ),

    GoRoute(
      path: '/mode-select',
      builder: (context, state) => ModeSelectScreen(),
    ),
    GoRoute(path: '/game', builder: (context, state) => GameScreen()),
    GoRoute(
      path: '/instructions',
      builder:
          (context, state) =>
              InstructionsScreen(), // Replace with actual instructions screen
    ),
    GoRoute(
      path: '/history',
      builder:
          (context, state) => Scaffold(
            body: Center(child: Text('History Screen')),
          ), // Replace with actual history screen
    ),
  ],
);
