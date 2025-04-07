import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hits_and_blows_game/src/constants/input_styles.dart';
import 'package:hits_and_blows_game/src/feature/game/providers/game_state_provider.dart';
import 'package:hits_and_blows_game/src/global/themes/theme.dart';

class NumberInputField extends ConsumerWidget {
  final int index;
  final Function(int) onChanged;
  final FocusNode focusNode;
  final TextEditingController controller;
  final int secretLength;

  const NumberInputField({
    super.key,
    required this.index,
    required this.onChanged,
    required this.focusNode,
    required this.controller,
    required this.secretLength,
  });

  void _onKeyPressed(KeyEvent event, int index) {
    // Only check on key down
    // if (event.logicalKey == LogicalKeyboardKey.backspace &&
    //     _controllers[index].text.isEmpty) {
    //   print('Backspace on empty field $index');
    //   if (index > 0) {
    //     FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);
    final isGameCompleted = gameState.gameCompleted;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        height: 60,
        width: 60,
        child: KeyboardListener(
          focusNode: focusNode,
          onKeyEvent: (event) => _onKeyPressed(event, index),
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            enabled: !isGameCompleted,
            style: AppTheme.inputTextStyle,
            decoration: inputDecoration,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              if (value.isNotEmpty) {
                final digit = int.parse(value);
                onChanged(digit);

                // Move focus to next field if available
                if (index < secretLength - 1) {
                  ref
                      .read(gameStateProvider.notifier)
                      .updateCurrentDigitIndex(index + 1);
                  FocusScope.of(context).nextFocus();
                } else {
                  // Last field, hide keyboard
                  FocusScope.of(context).requestFocus(focusNode);
                }
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }
            },
          ),
        ),
      ),
    );
  }
}
