import 'package:flutter/widgets.dart';
import 'package:pin_lock/src/controller/pin_lock_controller.dart';

class PinLockProvider extends InheritedWidget {
  const PinLockProvider({
    required this.controller,
    required super.child,
    super.key,
  });

  final PinLockController controller;

  static PinLockProvider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PinLockProvider>();
  }

  static PinLockProvider of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No PinLockProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(PinLockProvider oldWidget) => controller != oldWidget.controller;
}
