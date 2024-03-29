import 'dart:async';

import 'package:pin_lock/src/lock_machine/configuration/storage/pin_lock_storage.dart';

class MemoryStorage implements PinLockStorage {
  MemoryStorage();

  List<int> _timestamps = [];

  final Map<String, int> _pins = {};

  @override
  FutureOr<List<int>> getTimestamps() => _timestamps;

  @override
  FutureOr<void> saveTimestamps(List<int> timestamps) {
    _timestamps = timestamps;
  }

  @override
  FutureOr<int?> getPin(String key) {
    return _pins[key];
  }

  @override
  FutureOr<void> savePin(String key, int input) {
    _pins[key] = input;
  }
}
