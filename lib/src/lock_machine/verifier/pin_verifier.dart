import 'dart:async';

import 'input/pin_input.dart';

abstract interface class PinVerifier<T extends PinInput> {
  FutureOr<bool> verifyPin(T input);
}
