import 'package:pin_lock/src/lock_machine/verifier/input/biometric_input.dart';
import 'package:pin_lock/src/lock_machine/verifier/pin_verifier.dart';

class BiometricVerifier extends PinVerifier<BiometricInput> {
  BiometricVerifier();

  @override
  Future<bool> verifyPin(BiometricInput input) async {
    return input.value;
  }
}
