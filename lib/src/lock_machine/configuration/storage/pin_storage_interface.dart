import 'dart:async';

abstract interface class PinStorageInterface {
  FutureOr<void> savePin(String key, int input);

  FutureOr<int?> getPin(String key);
}
