sealed class LockState {
  const LockState();
}

class Uninitialised extends LockState {
  const Uninitialised();

  @override
  String toString() => 'Uninitialised';
}

class Locked extends LockState {
  const Locked();

  @override
  String toString() => 'Locked';
}

class UnLocked extends LockState {
  const UnLocked();

  @override
  String toString() => 'UnLocked';
}

class Blocked extends LockState {
  const Blocked();

  @override
  String toString() => 'Blocked';
}
