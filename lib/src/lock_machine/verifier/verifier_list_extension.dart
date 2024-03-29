import 'package:pin_lock/src/lock_machine/configuration/storage/pin_lock_storage.dart';
import 'package:pin_lock/src/lock_machine/verifier/input/pin_input.dart';
import 'package:pin_lock/src/lock_machine/verifier/pin_verifier.dart';

extension VerifierListExtension on List<PinVerifier> {
  Future<bool> verifyPin(PinInput input, PinLockStorage storage) async {
    final verifications = where((element) => element.verifiesType(input)).map((element) {
      return element.verifyPin(input, storage);
    });

    return (await Future.wait(verifications)).any((a) => a);
  }
}
