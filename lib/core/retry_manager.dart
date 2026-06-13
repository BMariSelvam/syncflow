import 'package:retry/retry.dart';

class RetryManager {
  static Future<T> retryRequest<T>({
    required Future<T> Function()
        request,
    required int maxAttempts,
    required Duration delay,
  }) async {
    final retryOptions =
        RetryOptions(
      maxAttempts: maxAttempts,
      delayFactor: delay,
    );

    return await retryOptions.retry(
      request,
    );
  }
}