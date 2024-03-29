import 'dart:async';

import 'package:pin_lock/src/lock_machine/configuration/storage/pin_storage_interface.dart';
import 'package:pin_lock/src/lock_machine/verifier/input/string_pin_input.dart';
import 'package:pin_lock/src/lock_machine/verifier/pin_verifier.dart';

class StringVerifier extends PinVerifier<StringPinInput> {
  StringVerifier();

  @override
  String get storageKey => 'string';

  @override
  Future<bool> verifyPin(StringPinInput input, PinStorageInterface storage) async {
    return input.hash == await storage.getPin(storageKey);
  }

  @override
  Future<bool> isVerified(PinStorageInterface storage) async {
    return await storage.getPin(storageKey) != null;
  }
}
