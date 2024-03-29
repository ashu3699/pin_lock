import 'package:pin_lock/src/lock_machine/configuration/storage/pin_storage_interface.dart';
import 'package:pin_lock/src/lock_machine/verifier/input/biometric_input.dart';
import 'package:pin_lock/src/lock_machine/verifier/pin_verifier.dart';

class BiometricVerifier extends PinVerifier<BiometricInput> {
  BiometricVerifier();

  @override
  String get storageKey => 'biometric';

  @override
  Future<bool> verifyPin(BiometricInput input, PinStorageInterface storage) async {
    return input.value;
  }
}
