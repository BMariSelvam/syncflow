import '../services/local_storage_service.dart';

class CacheManager {
  static Future<void> save(
    String key,
    dynamic value,
  ) async {
    await LocalStorageService.cache
        .put(key, value);
  }

  static dynamic get(String key) {
    return LocalStorageService.cache
        .get(key);
  }

  static Future<void> remove(
    String key,
  ) async {
    await LocalStorageService.cache
        .delete(key);
  }

  static Future<void> clear() async {
    await LocalStorageService.cache
        .clear();
  }
}