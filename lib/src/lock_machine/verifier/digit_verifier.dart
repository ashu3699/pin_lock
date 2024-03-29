import 'dart:async';

import '../configuration/storage/pin_storage_interface.dart';
import 'input/digit_pin_input.dart';
import 'pin_verifier.dart';

class DigitVerifier implements PinVerifier<DigitPinInput> {
  DigitVerifier(this._storageConfig);

  final PinStorageInterface _storageConfig;

  @override
  FutureOr<bool> verifyPin(DigitPinInput input) async {
    return input.hash == await _storageConfig.getPin();
  }
}
