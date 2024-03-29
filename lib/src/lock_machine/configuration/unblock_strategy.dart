import 'package:pin_lock/src/lock_machine/configuration/storage/attempt_storage_interface.dart';

abstract interface class UnblockStrategy {
  Future<bool> isBlocked();
}

class LinearUnBlockStrategy implements UnblockStrategy {
  LinearUnBlockStrategy({
    required this.storage,
    required this.initialTime,
    required this.incrementTime,
    required this.maximumTime,
  }) : _current = initialTime;

  final AttemptStorageInterface storage;
  final Duration initialTime;
  final Duration incrementTime;
  final Duration maximumTime;

  Duration _current;

  @override
  Future<bool> isBlocked() async {
    final timestamps = await storage.getTimestamps();

    if (timestamps.isNotEmpty) {
      final isBlocked =
          (DateTime.now().millisecondsSinceEpoch - timestamps.last) <
              _current.inMilliseconds;
      if (isBlocked) {
        if (_current + incrementTime < maximumTime) {
          _current += incrementTime;
        } else {
          _current = maximumTime;
        }
      }
      return isBlocked;
    }

    return false;
  }
}
