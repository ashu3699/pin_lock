import 'pin_input.dart';

class DigitPinInput extends PinInput<int> {
  DigitPinInput(this.value);

  @override
  final int value;

  @override
  int get hash => value.hashCode;
}
