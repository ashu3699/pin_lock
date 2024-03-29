import 'package:pin_lock/src/lock_machine/configuration/storage/pin_lock_storage.dart';
import 'package:pin_lock/src/lock_machine/configuration/unlock_strategy.dart';
import 'package:pin_lock/src/lock_machine/verifier/pin_verifier.dart';

class PinLockConfiguration {
  PinLockConfiguration({
    required this.verifiers,
    required this.unlockStrategy,
    required this.storage,
    // required this.blockStrategy,
    // required this.timeoutStrategy,
  });

  final List<PinVerifier> verifiers;
  final UnlockStrategy unlockStrategy;

  final PinLockStorage storage;

// final BlockStrategy blockStrategy;
// final TimeoutStrategy timeoutStrategy;

  // todo: implement get initialised call
  bool get isInitialised => true;
}
