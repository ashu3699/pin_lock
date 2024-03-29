
import 'dart:async';

import '../configuration/storage/pin_storage_interface.dart';
import 'input/string_pin_input.dart';
import 'pin_verifier.dart';

class StringVerifier implements PinVerifier<StringPinInput> {
  StringVerifier(this._storageConfig);

  final PinStorageInterface _storageConfig;

  @override
  FutureOr<bool> verifyPin(StringPinInput input) async {
      return input.hash == await _storageConfig.getPin();
  }
}

