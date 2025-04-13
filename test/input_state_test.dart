import 'package:flutter_test/flutter_test.dart';
import 'package:hits_and_blows_game/src/feature/game/providers/input_provider.dart';

import 'utils/provider_container_util.dart';

void main() {
  test('controller focusnode and key is created', () {
    final container = createContainer();
    final state = container.read(singleInputProvider);

    expect(state.controller, isNotNull);
    expect(state.focusNode, isNotNull);
    expect(state.formKey, isNotNull);
  });

  test('get digits returns correctly', () {
    final container = createContainer();
    final state = container.read(singleInputProvider);

    state.controller.text = '1234';

    expect(state.getDigits(), [1, 2, 3, 4]);
  });

  test('clear resets the controller text', () {
    final container = createContainer();
    final state = container.read(singleInputProvider);

    state.controller.text = '1234';
    state.clear();

    expect(state.controller.text, isEmpty);
  });
}
