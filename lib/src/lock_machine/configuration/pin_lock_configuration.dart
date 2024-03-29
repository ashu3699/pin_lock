import 'package:pin_lock/src/lock_machine/configuration/unlock_strategy.dart';
import 'package:pin_lock/src/lock_machine/verifier/pin_verifier.dart';

class PinLockConfiguration {
  PinLockConfiguration({
    required this.verifier,
    required this.unlockStrategy,
    // required this.blockStrategy,
    // required this.timeoutStrategy,
  });

  final PinVerifier verifier;
  final UnlockStrategy unlockStrategy;
// final BlockStrategy blockStrategy;
// final TimeoutStrategy timeoutStrategy;

  // todo: implement get initialised call
  bool get isInitialised => true;
}
