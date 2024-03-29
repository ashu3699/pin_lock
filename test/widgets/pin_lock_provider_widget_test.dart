import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pin_lock/pin_lock.dart';

void main() {
  testWidgets('PinLockProvider should provide a PinLockController', (WidgetTester tester) async {
    BuildContext? innerContext;
    await tester.pumpWidget(
      PinLockProvider(
        controller: await PinLockController.initialize(
          PinLockConfiguration(
            verifiers: [DigitVerifier()],
            storage: MemoryStorage()..savePin(DigitVerifier().storageKey, 1234.hashCode),
            unlockStrategy: TimeBasedAttemptsStrategy(
              maxAttempts: 5,
              timeout: const Duration(minutes: 5),
              storage: MemoryStorage(),
            ),
          ),
        ),
        child: Builder(
          builder: (context) {
            innerContext = context;

            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(PinLockProvider.maybeOf(innerContext!)?.controller, isA<PinLockController>());
  });
}
