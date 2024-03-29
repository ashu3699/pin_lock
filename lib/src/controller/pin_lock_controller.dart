import 'package:pin_lock/pin_lock.dart';
import 'package:pin_lock/src/lock_machine/lock_state.dart';
import 'package:pin_lock/src/lock_machine/verifier/input/biometric_input.dart';
import 'package:pin_lock/src/lock_machine/verifier/input/pin_input.dart';
import 'package:pin_lock/src/lock_machine/verifier/verifier_list_extension.dart';

class PinLockController {
  PinLockController(this.configuration) {
    _initialize();
  }

  final PinLockConfiguration configuration;

  late LockStateMachine _lockStateMachine;

  void _initialize() {
    if (configuration.isInitialised) {
      _lockStateMachine = LockStateMachine(
        initialState: const Locked(),
      );
    } else {
      _lockStateMachine = LockStateMachine();
    }
  }

  Stream<LockState> get stream => _lockStateMachine.stream;
  LockState get state => _lockStateMachine.state;

  Future<bool> verifyPin(PinInput input) => configuration.verifiers.verifyPin(input);

  void lock() {
    _lockStateMachine.update(Lock(), configuration);
  }

  void unlock(PinInput input) {
    _lockStateMachine.update(Unlock(input), configuration);
  }

  void biometricUnlock() {
    print('Biometric unlocking...');

    final success = _doBiometricUnlock();

    _lockStateMachine.update(Unlock(BiometricInput(success)), configuration);
  }

  bool _doBiometricUnlock() {
    print('Doing biometric unlock...');

    return true;
  }

  void reset() {
    _lockStateMachine.update(Remove(), configuration);
  }

  void setPin(PinInput input) {
    //to-do: implement set pin
    _lockStateMachine.update(Setup(), configuration);
  }
}
