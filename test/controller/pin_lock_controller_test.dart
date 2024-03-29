import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pin_lock/pin_lock.dart';
import 'package:pin_lock/src/lock_machine/lock_state.dart';

import '../mocks/mock_pin_lock_configuration.dart';

void main() {
  test('PinLockController should have an initial state if configuration is loaded', () async {
    final PinLockConfiguration configuration = MockPinLockConfiguration();

    when(() => configuration.isInitialised).thenReturn(true);

    final controller = PinLockController(configuration);

    expect(controller.state, isA<Locked>());

    StreamSubscription<LockState>? subscription;

    subscription = controller.stream.listen((event) {
      expect(event, isA<Locked>());

      subscription!.cancel();
    });
  });

  test('PinLockController should have an initial state if configuration is not loaded', () async {
    final PinLockConfiguration configuration = MockPinLockConfiguration();

    when(() => configuration.isInitialised).thenReturn(false);

    final controller = PinLockController(configuration);

    expect(controller.state, isA<Uninitialised>());

    StreamSubscription<LockState>? subscription;

    subscription = controller.stream.listen((event) {
      expect(event, isA<Uninitialised>());

      subscription!.cancel();
    });
  });
}
