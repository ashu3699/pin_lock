import 'package:flutter_test/flutter_test.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:pin_lock/pin_lock.dart';
import 'package:pin_lock/src/lock_machine/lock_state.dart';

void main() {
  test('LockStateMachine should be in Uninitialised state after creation', () {
    final machine = LockStateMachine();

    expect(machine.state, isA<Uninitialised>());
  });

  parameterizedTest3(
    'LockStateMachine should update to the correct new state',
    [
      // Uninitialised state
      [const Uninitialised(), Setup(), const Locked()],
      [const Uninitialised(), Remove(), const Uninitialised()],
      [const Uninitialised(), Lock(), const Uninitialised()],
      [const Uninitialised(), Unlock(DigitPinInput(1234)), const Uninitialised()],
      // UnLocked state
      [const UnLocked(), Setup(), const UnLocked()],
      [const UnLocked(), Remove(), const Uninitialised()],
      [const UnLocked(), Lock(), const Locked()],
      [const UnLocked(), Unlock(DigitPinInput(1234)), const UnLocked()],
      // Locked state
      [const Locked(), Setup(), const Locked()],
      [const Locked(), Remove(), const Uninitialised()],
      [const Locked(), Lock(), const Locked()],
      [const Locked(), Unlock(DigitPinInput(1234)), const UnLocked()],
      [const Locked(), Unlock(DigitPinInput(4321)), const Locked()],
      // Blocked state
      [const Blocked(), Setup(), const Blocked()],
      [const Blocked(), Remove(), const Uninitialised()],
      [const Blocked(), Lock(), const Blocked()],
      [const Blocked(), Unlock(DigitPinInput(1234)), const Blocked()],
    ],
    (LockState initialState, LockEvent event, LockState expectedState) async {
      final configuration = PinLockConfiguration(
        storage: MemoryStorage()..savePin(DigitVerifier().storageKey, 1234.hashCode),
        verifiers: [DigitVerifier()],
        unlockStrategy: TimeBasedAttemptsStrategy(
          maxAttempts: 5,
          timeout: const Duration(minutes: 5),
          storage: MemoryStorage(),
        ),
      );

      final machine = LockStateMachine(
        initialState: initialState,
      );

      await machine.update(event, configuration);

      expect(machine.state.runtimeType, expectedState.runtimeType);
    },
  );
}
