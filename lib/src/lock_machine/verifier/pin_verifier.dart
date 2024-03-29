import 'dart:async';

import 'package:pin_lock/src/lock_machine/configuration/storage/pin_lock_storage.dart';
import 'package:pin_lock/src/lock_machine/configuration/storage/pin_storage_interface.dart';
import 'package:pin_lock/src/lock_machine/verifier/input/pin_input.dart';

abstract class PinVerifier<T extends PinInput> {
  Future<bool> verifyPin(T input, PinLockStorage storage);
  String get storageKey;

  bool verifiesType(PinInput input) => input is T;
  Future<bool> isVerified(PinStorageInterface storage);
}
