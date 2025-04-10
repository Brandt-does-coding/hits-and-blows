import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hits_and_blows_game/src/feature/game/models/input_state.dart';

final singleInputProvider = Provider.autoDispose<InputState>((ref) {
  final state = InputState();
  ref.onDispose(state.dispose);
  return state;
});
