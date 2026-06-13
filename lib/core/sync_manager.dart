import 'package:uuid/uuid.dart';

import '../config/sync_config.dart';
import '../models/queued_request.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import '../utils/logger.dart';

import 'connectivity_service.dart';
import 'request_queue.dart';
import 'retry_manager.dart';

class SyncManager {
  static final Uuid _uuid = Uuid();

  static bool _isSyncing = false;

  static late SyncConfig config;

  static Future<void> initialize({
    SyncConfig? syncConfig,
  }) async {
    config =
        syncConfig ?? const SyncConfig();

    await LocalStorageService.init();

    SyncLogger.enabled =
        config.enableLogs;

    ConnectivityService
        .connectionStream
        .listen((isConnected) {
      if (isConnected) {
        processQueue();
      }
    });
  }

  static Future<void> request({
    required String method,
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    try {
      SyncLogger.log(
        'Trying API Request',
      );

      await RetryManager.retryRequest(
        request: () async {
          await ApiService.request(
            method: method,
            url: url,
            body: body,
            headers: headers,
          );
        },
        maxAttempts:
            config.retryCount,
        delay: config.retryDelay,
      );

      SyncLogger.log(
        'API Success',
      );
    } catch (e) {
      SyncLogger.log(
        'API Failed -> Saving Queue',
      );

      final request =
          QueuedRequest(
        id: _uuid.v4(),
        url: url,
        method: method,
        body: body,
        headers: headers,
        createdAt: DateTime.now(),
      );

      await RequestQueue.add(
        request,
      );
    }
  }

  static Future<void>
      processQueue() async {
    if (_isSyncing) return;

    _isSyncing = true;

    final requests =
        RequestQueue.getAll();

    for (final request
        in requests) {
      try {
        await ApiService.request(
          method: request.method,
          url: request.url,
          body: request.body,
          headers: request.headers,
        );

        await RequestQueue.remove(
          request.id,
        );

        SyncLogger.log(
          'Synced Request: ${request.id}',
        );
      } catch (e) {
        SyncLogger.log(
          'Sync Failed: ${request.id}',
        );
      }
    }

    _isSyncing = false;
  }
}