// number_inputs.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hits_and_blows_game/src/constants/input_styles.dart';
import 'package:hits_and_blows_game/src/feature/game/providers/input_provider.dart';
import 'package:hits_and_blows_game/src/feature/game/utils/game_utils.dart';
import 'package:pinput/pinput.dart';

class NumberInputs extends ConsumerStatefulWidget {
  final AnimationController shakeController;
  final int secretLength;
  final bool showInvalidInputMessage;
  final VoidCallback setInvalidMessage;
  final List<int?> currentGuess;

  const NumberInputs({
    super.key,
    required this.shakeController,
    required this.secretLength,
    required this.showInvalidInputMessage,
    required this.setInvalidMessage,
    required this.currentGuess,
  });

  @override
  ConsumerState<NumberInputs> createState() => _NumberInputsState();
}

class _NumberInputsState extends ConsumerState<NumberInputs>
    with SingleTickerProviderStateMixin {
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    _shakeAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: widget.shakeController, curve: Curves.elasticIn),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inputState = ref.watch(singleInputProvider);

    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            widget.showInvalidInputMessage ? _shakeAnimation.value : 0,
            0,
          ),
          child: child,
        );
      },
      child: Form(
        key: inputState.formKey,
        child: Pinput(
          length: widget.secretLength,
          controller: inputState.controller,
          validator:
              (value) => GameUtils.isValidGuess(value, widget.secretLength),
          focusNode: inputState.focusNode,
          defaultPinTheme: kDefaultPinTheme,
        ),
      ),
      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: List.generate(widget.secretLength, (index) {
      //     return NumberInputField(
      //       index: index,
      //       secretLength: widget.secretLength,
      //       controller: textfieldControllers.controllers[index],
      //       focusNode: textfieldControllers.focusNodes[index],
      //       onChanged: (digit) {
      //         setState(() {
      //           widget.currentGuess[index] = digit;
      //           widget.setInvalidMessage;
      //         });
      //       },
      //     );
      //   }),
      // ),
    );
  }
}
