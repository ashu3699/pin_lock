import 'package:pin_lock/pin_lock.dart';
import 'package:pin_lock/src/lock_machine/lock_state.dart';
import 'package:pin_lock/src/lock_machine/verifier/input/pin_input.dart';

class PinLockController {
  PinLockController(this.configuration) {
    _initialize();
  }

  final PinLockConfiguration configuration;

  late LockStateMachine _lockStateMachine;

  void _initialize() {
    if (configuration.isInitialised) {
      _lockStateMachine = LockStateMachine();
    } else {
      _lockStateMachine = LockStateMachine(
        initialState: const Locked(),
      );
    }
  }

  void lock() {
    print('Locking...');
  }

  void unlock() {
    print('Unlocking...');
  }

  void biometricUnlock() {
    print('Biometric unlocking...');
  }

  void reset() {
    print('Resetting...');
  }

  void setup(PinInput input) {
    print('Setting up...');
  }
}
