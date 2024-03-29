import 'dart:async';

import 'attempt_storage_interface.dart';
import 'pin_storage_interface.dart';

class MemoryStorage implements AttemptStorageInterface, PinStorageInterface {
  MemoryStorage();

  List<int> _timestamps = [];
  int _pin = 0;

  @override
  FutureOr<List<int>> getTimestamps() => _timestamps;

  @override
  FutureOr<void> saveTimestamps(List<int> timestamps) {
    _timestamps = timestamps;
  }

  @override
  FutureOr<int> getPin() {
    return _pin;
  }

  @override
  FutureOr<void> savePin(int input) {
    _pin = input;
  }
}
