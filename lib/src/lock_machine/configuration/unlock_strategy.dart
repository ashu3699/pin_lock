import 'dart:async';

import 'package:pin_lock/src/lock_machine/configuration/storage/attempt_storage_interface.dart';

abstract interface class UnlockStrategy {
  FutureOr<bool> onAttempt();

  void failedAttempt();
}

class TimeBasedAttemptsStrategy extends UnlockStrategy {
  TimeBasedAttemptsStrategy(
      {required this.maxAttempts,
      required this.timeout,
      required this.storage});

  final int maxAttempts;
  final Duration timeout;
  final AttemptStorageInterface storage;

  @override
  void failedAttempt() async {
    final timestamps = await storage.getTimestamps();
    if (timestamps.length >= maxAttempts) {
      timestamps.removeAt(0);
    }
    timestamps.add(DateTime.now().millisecondsSinceEpoch);
  }

  @override
  FutureOr<bool> onAttempt() async {
    final timestamps = await storage.getTimestamps();
    final now = DateTime.now().millisecondsSinceEpoch;

    final attempts = timestamps
        .where((timestamp) => now - timestamp <= timeout.inMilliseconds)
        .toList()
        .length;

    final isValid = attempts < maxAttempts;
    if (isValid) {
      storage.saveTimestamps([]);
    } else {
      failedAttempt();
    }
    return isValid;
  }
}
