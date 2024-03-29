import 'dart:async';

import 'package:pin_lock/src/lock_machine/configuration/pin_lock_configuration.dart';
import 'package:pin_lock/src/lock_machine/lock_event.dart';
import 'package:pin_lock/src/lock_machine/lock_state.dart';

class LockStateMachine {
  LockStateMachine({LockState initialState = const Uninitialised()}) {
    _setState(initialState);
  }

  late LockState _state;

  LockState get state => _state;

  final StreamController<LockState> _controller = StreamController<LockState>.broadcast();

  Stream<LockState> get stream => _controller.stream;

  void _setState(LockState state) {
    _state = state;
    _controller.add(state);
  }

  Future<void> update(LockEvent event, PinLockConfiguration configuration) async {
    final updatedState = await event.updateState(state, configuration);
    print('$_state --$event--> $updatedState');
    _setState(updatedState);
  }
}
