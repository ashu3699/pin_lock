import 'dart:async';

import 'package:pin_lock/src/lock_machine/lock_event.dart';
import 'package:pin_lock/src/lock_machine/lock_state2.dart';
import 'package:pin_lock/src/lock_machine/configuration/pin_lock_configuration.dart';

class LockStateMachine {
  LockStateMachine(this._configuration) {
    _setState(const Uninitialised());
  }

  final PinLockConfiguration _configuration;

  late LockState2 _state;

  LockState2 get state => _state;

  final StreamController<LockState2> _controller =
      StreamController<LockState2>.broadcast();

  Stream<LockState2> get stream => _controller.stream;

  void _setState(LockState2 state) {
    _state = state;
    _controller.add(state);
  }

  void update(LockEvent event) async {
    final updatedState = await event.updateState(state, _configuration);
    print('$_state --$event--> $updatedState');
    _setState(updatedState);
  }
}
