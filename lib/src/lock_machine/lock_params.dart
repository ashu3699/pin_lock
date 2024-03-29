class LockParams {
  LockParams({
    required this.timestamps,
  });

  final List<int> timestamps;

  LockParams copyWith({List<int>? timestamps}) => LockParams(
        timestamps: timestamps ?? this.timestamps,
      );
}
