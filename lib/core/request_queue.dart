import '../models/queued_request.dart';
import '../services/local_storage_service.dart';

class RequestQueue {
  static Future<void> add(
    QueuedRequest request,
  ) async {
    await LocalStorageService.queue
        .put(
      request.id,
      request.toJson(),
    );
  }

  static List<QueuedRequest>
      getAll() {
    return LocalStorageService
        .queue.values
        .map(
          (e) =>
              QueuedRequest.fromJson(
            e,
          ),
        )
        .toList();
  }

  static Future<void> remove(
    String id,
  ) async {
    await LocalStorageService.queue
        .delete(id);
  }

  static Future<void> clear() async {
    await LocalStorageService.queue
        .clear();
  }
}