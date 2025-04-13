import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hits_and_blows_game/src/feature/game/providers/game_state_provider.dart';
import 'package:hits_and_blows_game/src/feature/game/widgets/History/guess_result_item.dart';
import 'package:hits_and_blows_game/src/feature/instructions/view/instructions_screen.dart';

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
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) => const InstructionsScreen(),
                  );
                },
                child: const Text('View Instructions'),
              ),
            ],
          ),
        )
        : Column(
          children: [
            if (guessHistory.isNotEmpty)
              GuessResultItem(
                guess: guessHistory[guessHistory.length - 1],
                isLatest: true,
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(
                color: Colors.yellow.withValues(alpha: 0.2),
                thickness: 2,
                indent: 16,
                endIndent: 16,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: guessHistory.length - 1,
                itemBuilder: (context, index) {
                  final reverseIndex = guessHistory.length - 2 - index;
                  return GuessResultItem(
                    guess: guessHistory[reverseIndex],
                    isLatest: false,
                  );
                },
              ),
            ),
          ],
        );
  }
}
