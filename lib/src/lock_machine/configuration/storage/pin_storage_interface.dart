import 'dart:async';

abstract interface class PinStorageInterface {
  FutureOr<void> savePin(int input);

  FutureOr<int> getPin();
}
