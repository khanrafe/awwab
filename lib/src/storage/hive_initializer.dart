import 'package:hive_flutter/hive_flutter.dart';

abstract final class HiveInitializer {
  static const _settingsBox = 'app_settings';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(_settingsBox);
  }
}
