import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hits_and_blows_game/src/feature/game/providers/game_state_provider.dart';
import 'package:hits_and_blows_game/src/feature/game/widgets/guess_result_item.dart';

class HistoryList extends ConsumerWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guessHistory = ref.watch(gameStateProvider).guessHistory;

    return guessHistory.isEmpty
        ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: Colors.yellow.shade600,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Make your first guess!',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              TextButton(
                onPressed: () => context.push('/instructions'),
                child: const Text('View Instructions'),
              ),
            ],
          ),
        )
        : ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: guessHistory.length,
          // No need for reverse parameter since we're already showing latest at top
          itemBuilder: (context, index) {
            // Direct index from the end of the list to show latest guess at the top

            final reverseIndex = guessHistory.length - 1 - index;
            final isLatest = reverseIndex == guessHistory.length - 1;
            return Column(
              children: [
                GuessResultItem(
                  guess: guessHistory[reverseIndex],
                  isLatest: reverseIndex == guessHistory.length - 1,
                ),
                if (isLatest)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(
                      color: Colors.yellow.withValues(alpha: 0.2),
                      thickness: 2,
                      indent: 16,
                      endIndent: 16,
                    ),
                  ),
              ],
            );
          },
        );
  }
}
