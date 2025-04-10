import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hits_and_blows_game/src/constants/button_styles.dart';
import 'package:hits_and_blows_game/src/constants/logo.dart';
import 'package:hits_and_blows_game/src/feature/game/providers/input_provider.dart';
import 'package:hits_and_blows_game/src/feature/game/widgets/fading_popup_overlay.dart';
import 'package:hits_and_blows_game/src/feature/game/widgets/feedback_message_box.dart';
import 'package:hits_and_blows_game/src/feature/game/widgets/history_list.dart';
import 'package:hits_and_blows_game/src/feature/game/widgets/number_inputs.dart';
import 'package:hits_and_blows_game/src/feature/game/providers/game_state_provider.dart';
import 'package:hits_and_blows_game/src/global/themes/theme.dart';
import 'package:hits_and_blows_game/src/feature/game/widgets/secret_code_reveal.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen>
    with SingleTickerProviderStateMixin {
  late int secretLength;
  late AnimationController _animationController;
  late List<int?> _currentGuess;
  String? _feedbackMessage;
  bool _showInvalidInputMessage = false;

  @override
  void initState() {
    super.initState();
    secretLength = ref.read(gameStateProvider.notifier).secretLength;
    _currentGuess = List.filled(secretLength, null);
    _feedbackMessage = 'Enter your $secretLength-digit guess';
    setUpAnimations();
  }

  setUpAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _clearInputs() {
    for (int i = 0; i < _currentGuess.length; i++) {
      _currentGuess[i] = null;
    }
    _showInvalidInputMessage = false;
  }

  void _submitGuess() {
    final inputForm = ref.watch(singleInputProvider);
    inputForm.focusNode.unfocus();
    final isValid = inputForm.formKey.currentState?.validate();
    print("Puggy thinks isValid is: $isValid");
    // Validate the guess
    // if (!GameUtils.isValidGuess(_currentGuess)) {
    //   setState(() {
    //     _showInvalidInputMessage = true;
    //     _feedbackMessage = 'Please enter $secretLength unique digits';
    //   });
    //   _animationController.forward().then((_) {
    //     _animationController.reverse();
    //   });
    //   return;
    // }

    // Submit the guess
    // Guess? guessResult = ref
    //     .read(gameStateProvider.notifier)
    //     .submitGuess(nonNullGuess);

    // // Reset the input fields
    // _clearInputs();

    // // Update feedback message based on the latest guess
    // final gameState = ref.read(gameStateProvider);

    // if (!gameState.gameCompleted && guessResult != null) {
    //   _showResultAnimation(guessResult.hits, guessResult.blows);
    // }

    // // Set focus to first field for next guess if game is not over
    // if (gameState.gameCompleted) {
    //   setState(() {
    //     _feedbackMessage = null;
    //     _showInvalidInputMessage = false;
    //   });
    // }
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

  void _startNewGame() {
    ref.read(gameStateProvider.notifier).newGame(secretLength);
    _clearInputs();
    setState(() {
      _feedbackMessage = 'Enter your $secretLength-digit guess';
      _showInvalidInputMessage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isGameCompleted = ref.watch(gameStateProvider).gameCompleted;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: appLogo,
          backgroundColor: Colors.blueGrey[900],
          leading: IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: Icon(Icons.home),
          ),
        ),

        backgroundColor: AppTheme.darkBackgroundColor,
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            spacing: 30.0,
            children: [
              if (!isGameCompleted)
                NumberInputs(
                  shakeController: _animationController,
                  secretLength: secretLength,
                  showInvalidInputMessage: _showInvalidInputMessage,
                  setInvalidMessage:
                      () => setState(() {
                        _showInvalidInputMessage = false;
                      }),
                  currentGuess: _currentGuess,
                ),
              if (isGameCompleted) SecretCodeReveal(),
              if (!isGameCompleted)
                ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle),
                  onPressed: _submitGuess,
                  label: const Text('Submit Guess'),
                  style: MainStyle(),
                ),
              if (isGameCompleted)
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  onPressed: _startNewGame,
                  label: const Text('New Game'),
                  style: MainStyle(),
                ),
              if (_showInvalidInputMessage && _feedbackMessage != null)
                FeedbackMessageBox(_showInvalidInputMessage, _feedbackMessage),
              Expanded(child: HistoryList()),
            ],
          ),
        ),
      ),
    );
  }
}
