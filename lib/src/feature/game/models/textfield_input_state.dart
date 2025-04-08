import 'package:flutter/material.dart';

class TextfieldInputState {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;

  TextfieldInputState._(this.controllers, this.focusNodes);

  factory TextfieldInputState.create({int fields = 4}) {
    final controllers = List.generate(fields, (_) => TextEditingController());
    final focusNodes = List.generate(fields, (_) => FocusNode());
    return TextfieldInputState._(controllers, focusNodes);
  }

  void onTextChanged(BuildContext context, int index) {
    String value = controllers[index].text;
    print(value);
    if (value.isEmpty && index > 0) {
      print("Go back one");
      // request focus for the previous "box"
      FocusScope.of(context).nextFocus();
      return;
    }
    if (value.isNotEmpty && index < focusNodes.length - 1) {
      print("go forward one");
      FocusScope.of(context).previousFocus();
    }
  }

  void moveFocusForward(BuildContext context) {
    FocusScope.of(context).nextFocus();
  }

  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
  }
}
