import 'package:awwab/src/app.dart';
import 'package:awwab/src/storage/hive_initializer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveInitializer.init();
  runApp(const ProviderScope(child: AwwabApp()));
}
