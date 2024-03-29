import 'dart:async';

import 'package:pin_lock/src/lock_machine/configuration/pin_lock_configuration.dart';
import 'package:pin_lock/src/lock_machine/lock_state2.dart';
import 'package:pin_lock/src/lock_machine/verifier/input/pin_input.dart';

import 'configuration/setup_strategy.dart';

sealed class LockEvent {
  Future<LockState2> updateState(
      LockState2 state, PinLockConfiguration configuration);
}

class Setup extends LockEvent {
  @override
  String toString() => 'Setup';

  @override
  Future<LockState2> updateState(
      LockState2 state, PinLockConfiguration configuration) async {
    return switch (state) {
      Uninitialised() => switch (configuration.setupStrategy) {
          SetupStrategy.Locked => const Locked2(),
          SetupStrategy.Unlocked => const Unlocked2(),
        },
      _ => state,
    };
  }
}

class Remove extends LockEvent {
  @override
  String toString() => 'Remove';

  @override
  Future<LockState2> updateState(
      LockState2 state, PinLockConfiguration configuration) async {
    return switch (state) {
      Unlocked2() => const Uninitialised(),
      _ => state,
    };
  }
}

class Lock extends LockEvent {
  @override
  String toString() => 'Lock';

  @override
  Future<LockState2> updateState(
      LockState2 state, PinLockConfiguration configuration) async {
    return switch (state) {
      Unlocked2() => const Locked2(),
      _ => state,
    };
  }
}

class Unlock extends LockEvent {
  @override
  String toString() => 'Unlock';

  Unlock(this.pin);

  final PinInput pin;

  @override
  Future<LockState2> updateState(
      LockState2 state, PinLockConfiguration configuration) async {
    return switch (state) {
      Locked2() => await _verifyPinAttempt(configuration),
      _ => state,
    };
  }

  Future<LockState2> _verifyPinAttempt(
      PinLockConfiguration configuration) async {
    final isCorrectPin = await configuration.verifier.verifyPin(pin);
    print('isCorrect: $isCorrectPin');
    if (isCorrectPin) {
      final isValidAttempt = await configuration.unlockStrategy.onAttempt();
      print('isValid: $isValidAttempt');
      if (isValidAttempt) {
        return const Unlocked2();
      }else {

      }
    } else {
      configuration.unlockStrategy.failedAttempt();
      //TODO: Block config here
    }
    return const Locked2();
  }
}
/// state is locked
/// - check pin
/// - false should block
///  - unlock
///
/// state is blocked
/// - is attempts valid
/// - true unblock
/// - unlock event
///

// class Reset extends LockEvent {
// @override
// String toString() => 'Reset';
//   @override
//   Future<LockState2> updateState(
//       LockState2 state, PinLockConfiguration configuration) async {}
// }
//
// class _Block extends LockEvent {
// @override
// String toString() => '_Block';
//   @override
//   Future<LockState2> updateState(
//       LockState2 state, PinLockConfiguration configuration) async {}
// }
//
// class _UnBlock extends LockEvent {
// @override
// String toString() => '_UnBlock';
//   @override
//   Future<LockState2> updateState(
//       LockState2 state, PinLockConfiguration configuration) async {}
// }
