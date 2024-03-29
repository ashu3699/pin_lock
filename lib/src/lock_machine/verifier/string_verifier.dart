import 'dart:async';

import 'package:pin_lock/src/lock_machine/configuration/storage/pin_storage_interface.dart';
import 'package:pin_lock/src/lock_machine/verifier/input/string_pin_input.dart';
import 'package:pin_lock/src/lock_machine/verifier/pin_verifier.dart';

class StringVerifier extends PinVerifier<StringPinInput> {
  StringVerifier(this._storageConfig);

  final PinStorageInterface _storageConfig;

  @override
  Future<bool> verifyPin(StringPinInput input) async {
    return input.hash == await _storageConfig.getPin();
  }
}
