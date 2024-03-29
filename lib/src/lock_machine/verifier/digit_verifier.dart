import 'dart:async';

import 'package:pin_lock/src/lock_machine/configuration/storage/pin_storage_interface.dart';
import 'package:pin_lock/src/lock_machine/verifier/input/digit_pin_input.dart';
import 'package:pin_lock/src/lock_machine/verifier/pin_verifier.dart';

class DigitVerifier extends PinVerifier<DigitPinInput> {
  DigitVerifier(this._storageConfig);

  final PinStorageInterface _storageConfig;

  @override
  Future<bool> verifyPin(DigitPinInput input) async {
    return input.hash == await _storageConfig.getPin();
  }
}
