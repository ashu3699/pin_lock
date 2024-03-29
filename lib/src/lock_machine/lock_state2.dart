sealed class LockState2 {
  const LockState2();
}

class Uninitialised extends LockState2 {
  const Uninitialised();

  @override
  String toString() => 'Uninitialised';
}

class Locked2 extends LockState2 {
  const Locked2();

  @override
  String toString() => 'Locked2';
}

class Unlocked2 extends LockState2 {
  const Unlocked2();

  @override
  String toString() => 'Unlocked2';
}

class Blocked extends LockState2 {
  const Blocked();

  @override
  String toString() => 'Blocked';
}
