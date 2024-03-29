import 'package:pin_lock/pin_lock.dart';
import 'package:pin_lock/src/lock_machine/lock_state.dart';
import 'package:pin_lock/src/lock_machine/verifier/input/biometric_input.dart';
import 'package:pin_lock/src/lock_machine/verifier/input/pin_input.dart';
import 'package:pin_lock/src/lock_machine/verifier/verifier_list_extension.dart';

class PinLockController {
  PinLockController._(this.configuration);

  final PinLockConfiguration configuration;

  late LockStateMachine _lockStateMachine;

  static Future<PinLockController> initialize(PinLockConfiguration configuration) async {
    final controller = PinLockController._(configuration);
    await controller._initialize();

    return controller;
  }

  Future<void> _initialize() async {
    if (await configuration.isInitialised) {
      _lockStateMachine = LockStateMachine(
        initialState: const Locked(),
      );
    } else {
      _lockStateMachine = LockStateMachine();
    }
  }

  Stream<LockState> get stream => _lockStateMachine.stream;
  LockState get state => _lockStateMachine.state;

  Future<bool> verifyPin(PinInput input) => configuration.verifiers.verifyPin(input, configuration.storage);

  Future<void> lock() async {
    return _lockStateMachine.update(Lock(), configuration);
  }

  Future<void> unlock(PinInput input) async {
    return _lockStateMachine.update(Unlock(input), configuration);
  }

  Future<void> biometricUnlock() async {
    print('Biometric unlocking...');

    final success = _doBiometricUnlock();

    return _lockStateMachine.update(Unlock(BiometricInput(success)), configuration);
  }

  bool _doBiometricUnlock() {
    print('Doing biometric unlock...');

    return true;
  }

  Future<void> reset() async {
    return _lockStateMachine.update(Remove(), configuration);
  }

  Future<void> setPin(PinInput input) async {
    return _lockStateMachine.update(Setup(input), configuration);
  }
}
