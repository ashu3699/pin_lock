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
  PinLockController? controller;

  @override
  void initState() {
    super.initState();
    storage = MemoryStorage()..savePin(DigitVerifier().storageKey, 1234.hashCode);
    createController();
  }

  void createController() async {
    controller = await PinLockController.initialize(
      PinLockConfiguration(
        storage: storage,
        verifiers: [DigitVerifier()],
        unlockStrategy: TimeBasedAttemptsStrategy(
          maxAttempts: 5,
          timeout: const Duration(minutes: 5),
          storage: storage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: controller == null
          ? const SizedBox.shrink()
          : PinLockProvider(
              controller: controller!,
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
