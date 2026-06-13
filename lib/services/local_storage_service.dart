import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const String queueBox =
      'sync_queue';

  static const String cacheBox =
      'sync_cache';

  static Future<void> init() async {
    await Hive.initFlutter();

    await Hive.openBox(queueBox);

    await Hive.openBox(cacheBox);
  }

  static Box get queue =>
      Hive.box(queueBox);

  static Box get cache =>
      Hive.box(cacheBox);
}