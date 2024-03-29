import 'dart:async';

import 'package:pin_lock/src/lock_machine/verifier/input/pin_input.dart';

abstract class PinVerifier<T extends PinInput> {
  Future<bool> verifyPin(T input);

  bool verifiesType(PinInput input) => input is T;
}
