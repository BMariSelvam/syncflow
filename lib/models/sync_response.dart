class SyncResponse<T> {
  final bool success;

  final T? data;

  final String? error;

  SyncResponse({
    required this.success,
    this.data,
    this.error,
  });
}