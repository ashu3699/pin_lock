import 'dart:async';

abstract interface class AttemptStorageInterface {
  FutureOr<List<int>> getTimestamps();

  FutureOr<void> saveTimestamps(List<int> timestamps);
}
