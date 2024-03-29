import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pin_lock/pin_lock.dart';
import 'package:pin_lock/src/lock_machine/lock_state.dart';
import 'package:pin_lock/src/lock_machine/verifier/biometric_verifier.dart';
import 'package:pin_lock/src/lock_machine/verifier/input/biometric_input.dart';
import 'package:pin_lock/src/lock_machine/verifier/input/string_pin_input.dart';
import 'package:pin_lock/src/lock_machine/verifier/string_verifier.dart';

import '../mocks/mock_pin_lock_configuration.dart';

void main() {
  group('Loading states', () {
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
  });

  group('verification', () {
    test('PinLockController should verify pin with digit verifier', () async {
      final storage = MemoryStorage()..savePin(DigitVerifier().storageKey, 1234.hashCode);

      final configuration = PinLockConfiguration(
        storage: storage,
        verifiers: [
          DigitVerifier(),
        ],
        unlockStrategy: TimeBasedAttemptsStrategy(
          maxAttempts: 5,
          timeout: const Duration(minutes: 5),
          storage: storage,
        ),
      );

      final controller = PinLockController(configuration);

      final input = DigitPinInput(1234);

      final result = await controller.verifyPin(input);

      expect(result, true);

      final input2 = DigitPinInput(4321);

      final result2 = await controller.verifyPin(input2);

      expect(result2, false);
    });

    test('PinLockController should verify pin with string verifier', () async {
      final storage = MemoryStorage()..savePin(StringVerifier().storageKey, 'asdf'.hashCode);

      final configuration = PinLockConfiguration(
        storage: storage,
        verifiers: [
          StringVerifier(),
        ],
        unlockStrategy: TimeBasedAttemptsStrategy(
          maxAttempts: 5,
          timeout: const Duration(minutes: 5),
          storage: storage,
        ),
      );

      final controller = PinLockController(configuration);

      final input = StringPinInput('asdf');

      final result = await controller.verifyPin(input);

      expect(result, true);

      final input2 = StringPinInput('qwer');

      final result2 = await controller.verifyPin(input2);

      expect(result2, false);
    });

    test('PinLockController should verify pin with biometric verifier', () async {
      final configuration = PinLockConfiguration(
        verifiers: [
          BiometricVerifier(),
        ],
        storage: MemoryStorage()..savePin(DigitVerifier().storageKey, 1234.hashCode),
        unlockStrategy: TimeBasedAttemptsStrategy(
          maxAttempts: 5,
          timeout: const Duration(minutes: 5),
          storage: MemoryStorage(),
        ),
      );

      final controller = PinLockController(configuration);

      final input = BiometricInput(true);

      final result = await controller.verifyPin(input);

      expect(result, true);

      final input2 = BiometricInput(false);

      final result2 = await controller.verifyPin(input2);

      expect(result2, false);
    });

    test('PinLockController should verify pin with multiple verifiers', () async {
      final storage = MemoryStorage()
        ..savePin(DigitVerifier().storageKey, 1234.hashCode)
        ..savePin(StringVerifier().storageKey, 'asdf'.hashCode);

      final configuration = PinLockConfiguration(
        storage: storage,
        verifiers: [
          DigitVerifier(),
          StringVerifier(),
          BiometricVerifier(),
        ],
        unlockStrategy: TimeBasedAttemptsStrategy(
          maxAttempts: 5,
          timeout: const Duration(minutes: 5),
          storage: storage,
        ),
      );

      final controller = PinLockController(configuration);

      final input = DigitPinInput(1234);

      final result = await controller.verifyPin(input);

      expect(result, true);

      final input2 = StringPinInput('asdf');

      final result2 = await controller.verifyPin(input2);

      expect(result2, true);

      final input3 = DigitPinInput(4321);

      final result3 = await controller.verifyPin(input3);

      expect(result3, false);

      final input4 = BiometricInput(true);

      final result4 = await controller.verifyPin(input4);

      expect(result4, true);
    });
  });
}
