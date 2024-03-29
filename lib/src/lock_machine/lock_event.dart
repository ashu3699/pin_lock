import 'dart:async';

import 'package:pin_lock/src/lock_machine/configuration/pin_lock_configuration.dart';
import 'package:pin_lock/src/lock_machine/configuration/setup_strategy.dart';
import 'package:pin_lock/src/lock_machine/lock_state.dart';
import 'package:pin_lock/src/lock_machine/verifier/input/pin_input.dart';

sealed class LockEvent {
  Future<LockState> updateState(
    LockState state,
    PinLockConfiguration configuration,
  );
}

class Setup extends LockEvent {
  @override
  String toString() => 'Setup';

  @override
  Future<LockState> updateState(
    LockState state,
    PinLockConfiguration configuration,
  ) async {
    return switch (state) {
      Uninitialised() => switch (configuration.setupStrategy) {
          SetupStrategy.Locked => const Locked(),
          SetupStrategy.Unlocked => const UnLocked(),
        },
      _ => state,
    };
  }
}

class Remove extends LockEvent {
  @override
  String toString() => 'Remove';

  @override
  Future<LockState> updateState(
    LockState state,
    PinLockConfiguration configuration,
  ) async {
    return switch (state) {
      UnLocked() => const Uninitialised(),
      _ => state,
    };
  }
}

class Lock extends LockEvent {
  @override
  String toString() => 'Lock';

  @override
  Future<LockState> updateState(
    LockState state,
    PinLockConfiguration configuration,
  ) async {
    return switch (state) {
      UnLocked() => const Locked(),
      _ => state,
    };
  }
}

class Unlock extends LockEvent {
  Unlock(this.pin);
  @override
  String toString() => 'Unlock';

  final PinInput pin;

  @override
  Future<LockState> updateState(
    LockState state,
    PinLockConfiguration configuration,
  ) async {
    return switch (state) {
      Locked() => await _verifyPinAttempt(configuration),
      _ => state,
    };
  }

  Future<LockState> _verifyPinAttempt(
    PinLockConfiguration configuration,
  ) async {
    final isCorrectPin = await configuration.verifier.verifyPin(pin);
    print('isCorrect: $isCorrectPin');
    if (isCorrectPin) {
      final isValidAttempt = await configuration.unlockStrategy.onAttempt();
      print('isValid: $isValidAttempt');
      if (isValidAttempt) {
        return const UnLocked();
      } else {}
    } else {
      configuration.unlockStrategy.failedAttempt();
      //TODO: Block config here
    }
    return const Locked();
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
//   Future<LockState> updateState(
//       LockState state, PinLockConfiguration configuration) async {}
// }
//
// class _Block extends LockEvent {
// @override
// String toString() => '_Block';
//   @override
//   Future<LockState> updateState(
//       LockState state, PinLockConfiguration configuration) async {}
// }
//
// class _UnBlock extends LockEvent {
// @override
// String toString() => '_UnBlock';
//   @override
//   Future<LockState> updateState(
//       LockState state, PinLockConfiguration configuration) async {}
// }
