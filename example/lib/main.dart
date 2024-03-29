import 'package:flutter/material.dart';
import 'package:pin_lock/pin_lock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MemoryStorage storage;

  late LockStateMachine machine;

  @override
  void initState() {
    super.initState();
    storage = MemoryStorage()..savePin(1234.hashCode);
    machine = LockStateMachine();

    machine.update(
        Setup(),
        PinLockConfiguration(
          verifier: DigitVerifier(storage),
          unlockStrategy: TimeBasedAttemptsStrategy(
            maxAttempts: 5,
            timeout: const Duration(minutes: 5),
            storage: storage,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
                stream: machine.stream,
                builder: (context, snapshot) {
                  return Text(snapshot.data.toString() ?? 'none');
                }),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                machine.update(
                    Unlock(DigitPinInput(1234)),
                    PinLockConfiguration(
                      verifier: DigitVerifier(storage),
                      unlockStrategy: TimeBasedAttemptsStrategy(
                        maxAttempts: 5,
                        timeout: const Duration(minutes: 5),
                        storage: storage,
                      ),
                    ));
              },
              child: const Text('correct pin'),
            ),
            ElevatedButton(
              onPressed: () {
                machine.update(
                    Unlock(DigitPinInput(4321)),
                    PinLockConfiguration(
                      verifier: DigitVerifier(storage),
                      unlockStrategy: TimeBasedAttemptsStrategy(
                        maxAttempts: 5,
                        timeout: const Duration(minutes: 5),
                        storage: storage,
                      ),
                    ));
              },
              child: const Text('incorrect pin'),
            ),
            ElevatedButton(
              onPressed: () {
                machine.update(
                    Lock(),
                    PinLockConfiguration(
                      verifier: DigitVerifier(storage),
                      unlockStrategy: TimeBasedAttemptsStrategy(
                        maxAttempts: 5,
                        timeout: const Duration(minutes: 5),
                        storage: storage,
                      ),
                    ));
              },
              child: const Text('Lock'),
            ),
          ],
        ),
      ),
    );
  }
}
