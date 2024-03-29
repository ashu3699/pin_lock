import 'pin_input.dart';

class StringPinInput extends PinInput<String> {
  StringPinInput(this.value);

  @override
  final String value;

  @override
  int get hash => value.hashCode;
}
