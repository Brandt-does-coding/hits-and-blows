import 'package:flutter/material.dart';
import 'package:hits_and_blows_game/src/feature/game/utils/game_utils.dart';

class InputState {
  final TextEditingController controller;
  final FocusNode focusNode;
  final GlobalKey<FormState> formKey;

  InputState()
    : controller = TextEditingController(),
      focusNode = FocusNode(),
      formKey = GlobalKey<FormState>();

  void clear() => controller.clear();

  List<int> getDigits() => GameUtils.getDigitsFromString(controller.text);

  void dispose() {
    controller.dispose();
    focusNode.dispose();
  }
}
