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

  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
  }
}
