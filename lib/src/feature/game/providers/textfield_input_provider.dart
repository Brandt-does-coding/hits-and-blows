import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hits_and_blows_game/src/feature/game/models/textfield_input_state.dart';

final textfieldInputProvider = Provider.family<TextfieldInputState, int>((
  ref,
  fieldCount,
) {
  final textfieldState = TextfieldInputState.create(fields: fieldCount);
  ref.onDispose(textfieldState.dispose); // clean up when provider is destroyed
  return textfieldState;
});
