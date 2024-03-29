import '../verifier/pin_verifier.dart';
import 'setup_strategy.dart';
import 'unlock_strategy.dart';

class PinLockConfiguration {
  PinLockConfiguration({
    required this.setupStrategy,
    required this.verifier,
    required this.unlockStrategy,
    // required this.blockStrategy,
    // required this.timeoutStrategy,
  });

  final SetupStrategy setupStrategy;
  final PinVerifier verifier;
  final UnlockStrategy unlockStrategy;
// final BlockStrategy blockStrategy;
// final TimeoutStrategy timeoutStrategy;
}
