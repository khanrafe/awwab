import 'package:awwab/src/routes/app_router.dart';
import 'package:awwab/src/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AwwabApp extends ConsumerWidget {
  const AwwabApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Awwab',
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
