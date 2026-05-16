import 'package:awwab/src/features/home/presentation/home_screen.dart';
import 'package:awwab/src/features/log_action/presentation/log_action_screen.dart';
import 'package:awwab/src/features/path_step/presentation/path_step_screen.dart';
import 'package:awwab/src/features/profile/presentation/profile_screen.dart';
import 'package:awwab/src/features/progress_analytics/presentation/progress_analytics_screen.dart';
import 'package:awwab/src/features/recovery_paths/presentation/recovery_paths_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: AppRoutes.home,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.home,
        name: AppRouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.logAction,
        name: AppRouteNames.logAction,
        builder: (context, state) => const LogActionScreen(),
      ),
      GoRoute(
        path: AppRoutes.recoveryPaths,
        name: AppRouteNames.recoveryPaths,
        builder: (context, state) => const RecoveryPathsScreen(),
      ),
      GoRoute(
        path: AppRoutes.pathStep,
        name: AppRouteNames.pathStep,
        builder: (context, state) => const PathStepScreen(),
      ),
      GoRoute(
        path: AppRoutes.progressAnalytics,
        name: AppRouteNames.progressAnalytics,
        builder: (context, state) => const ProgressAnalyticsScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        name: AppRouteNames.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  ),
);

abstract final class AppRoutes {
  static const home = '/';
  static const logAction = '/log-action';
  static const recoveryPaths = '/recovery-paths';
  static const pathStep = '/path-step';
  static const progressAnalytics = '/progress-analytics';
  static const profile = '/profile';
}

abstract final class AppRouteNames {
  static const home = 'home';
  static const logAction = 'logAction';
  static const recoveryPaths = 'recoveryPaths';
  static const pathStep = 'pathStep';
  static const progressAnalytics = 'progressAnalytics';
  static const profile = 'profile';
}
