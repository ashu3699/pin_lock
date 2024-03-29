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

  @override
  void initState() {
    super.initState();
    storage = MemoryStorage()..savePin(1234.hashCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PinLockProvider(
        controller: PinLockController(PinLockConfiguration(
          verifier: DigitVerifier(storage),
          unlockStrategy: TimeBasedAttemptsStrategy(
            maxAttempts: 5,
            timeout: const Duration(minutes: 5),
            storage: storage,
          ),
        )),
        child: Center(
          child: Builder(builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(PinLockProvider.maybeOf(context)?.controller.toString() ?? 'No controller found'),
              ],
            );
          }),
        ),
      ),
    );
  }
}
