sealed class LockState {
  const LockState();
}

class Uninitialised extends LockState {
  const Uninitialised();

  @override
  String toString() => 'Uninitialised';
}

class Locked2 extends LockState {
  const Locked2();

  @override
  String toString() => 'Locked2';
}

class Unlocked2 extends LockState {
  const Unlocked2();

  @override
  String toString() => 'Unlocked2';
}

class Blocked extends LockState {
  const Blocked();

  @override
  String toString() => 'Blocked';
}
