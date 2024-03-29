import 'dart:async';

import 'package:pin_lock/src/lock_machine/configuration/pin_lock_configuration.dart';
import 'package:pin_lock/src/lock_machine/lock_event.dart';
import 'package:pin_lock/src/lock_machine/lock_state.dart';

class LockStateMachine {
  LockStateMachine(this._configuration) {
    _setState(const Uninitialised());
  }

  final PinLockConfiguration _configuration;

  late LockState _state;

  LockState get state => _state;

  final StreamController<LockState> _controller = StreamController<LockState>.broadcast();

  Stream<LockState> get stream => _controller.stream;

  void _setState(LockState state) {
    _state = state;
    _controller.add(state);
  }

  void update(LockEvent event) async {
    final updatedState = await event.updateState(state, _configuration);
    print('$_state --$event--> $updatedState');
    _setState(updatedState);
  }
}
