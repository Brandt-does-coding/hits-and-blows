import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hits_and_blows_game/src/feature/game/providers/game_state_provider.dart';
import 'package:hits_and_blows_game/src/global/themes/theme.dart';

class SecretCodeReveal extends ConsumerWidget {
  const SecretCodeReveal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final secretCode = ref.read(gameStateProvider).secretCode;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.correctColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.correctColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            secretCode.map((digit) {
              return Container(
                height: 50,
                width: 50,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.correctColor),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$digit',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.correctColor,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
