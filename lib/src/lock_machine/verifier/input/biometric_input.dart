import 'package:pin_lock/src/lock_machine/verifier/input/pin_input.dart';

class BiometricInput extends PinInput<bool> {
  BiometricInput(this.value);

  @override
  final bool value;

  @override
  int get hash => value.hashCode;
}
