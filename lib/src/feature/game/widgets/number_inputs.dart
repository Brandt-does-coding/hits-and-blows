// number_inputs.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hits_and_blows_game/src/constants/input_styles.dart';
import 'package:hits_and_blows_game/src/feature/game/models/guess.dart';
import 'package:hits_and_blows_game/src/feature/game/providers/game_state_provider.dart';
import 'package:hits_and_blows_game/src/feature/game/providers/input_provider.dart';
import 'package:hits_and_blows_game/src/feature/game/utils/game_utils.dart';
import 'package:hits_and_blows_game/src/feature/game/widgets/fading_popup_overlay.dart';
import 'package:pinput/pinput.dart';

class NumberInputs extends ConsumerStatefulWidget {
  const NumberInputs({super.key});

  @override
  ConsumerState<NumberInputs> createState() => _NumberInputsState();
}

class _NumberInputsState extends ConsumerState<NumberInputs>
    with SingleTickerProviderStateMixin {
  late Animation<double> _shakeAnimation;
  late AnimationController _shakeController;
  late int secretLength;

  @override
  void initState() {
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
    secretLength = ref.read(gameStateProvider.notifier).secretLength;
    super.initState();
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  String? _validateForm(String? value) {
    final String? errorText = GameUtils.isValidGuess(value, secretLength);
    if (errorText == null) {
      _submitGuess(value);
    }
    if (errorText != null) {
      _shakeController.forward().then((_) {
        _shakeController.reverse();
      });
    }
    return errorText;
  }

  void _submitGuess(String? value) {
    final inputForm = ref.read(singleInputProvider);
    //Continue to submit since the guess is valid
    final guessDigits = inputForm.getDigits();

    // Submit the guess
    Guess? guessResult = ref
        .read(gameStateProvider.notifier)
        .submitGuess(guessDigits);
    inputForm.controller.clear();

    // // Update feedback message based on the latest guess
    final gameState = ref.read(gameStateProvider);

    if (!gameState.gameCompleted && guessResult != null) {
      _showResultAnimation(guessResult.hits, guessResult.blows);
    }
  }

  void _showResultAnimation(int hits, int blows) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;
    final animationDuration = Duration(milliseconds: 300);
    final displayDuration = Duration(milliseconds: 1000);
    double opacity = 1.0;

    overlayEntry = OverlayEntry(
      builder:
          (context) => Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: Colors.black87),
            child: FadingPopupOverlay(
              hits: hits,
              blows: blows,
              opacity: opacity,
            ),
          ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(displayDuration, () {
      opacity = 0.0;
      overlayEntry.markNeedsBuild(); // Trigger rebuild with new opacity

      Future.delayed(animationDuration, () {
        overlayEntry.remove();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final inputState = ref.watch(singleInputProvider);

    return Form(
      key: inputState.formKey,
      child: AnimatedBuilder(
        animation: _shakeAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_shakeAnimation.value, 0),
            child: child,
          );
        },
        child: Pinput(
          length: secretLength,
          controller: inputState.controller,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          validator: (value) => _validateForm(value),
          pinputAutovalidateMode: PinputAutovalidateMode.disabled,
          focusNode: inputState.focusNode,
          defaultPinTheme: kDefaultPinTheme,
          submittedPinTheme: kDefaultPinTheme,
          errorBuilder: (errorText, pin) => errorInputWidget(errorText, pin),
        ),
      ),
    );
  }

  Widget errorInputWidget(String? errorText, String pin) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        color: Colors.red[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(
            errorText ?? '',
            style: const TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
