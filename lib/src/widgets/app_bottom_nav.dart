import 'package:awwab/src/routes/app_router.dart';
import 'package:awwab/src/theme/app_motion.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppNavTab { home, tasks, progress, profile }

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.activeTab});

  final AppNavTab activeTab;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppRadius.md),
      boxShadow: AppShadows.card,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _NavItem(
              active: activeTab == AppNavTab.home,
              tab: AppNavTab.home,
              icon: Icons.home_outlined,
              activeIcon: Icons.home_filled,
              label: 'Home',
            ),
          ),
          Expanded(
            child: _NavItem(
              active: activeTab == AppNavTab.tasks,
              tab: AppNavTab.tasks,
              icon: Icons.checklist_rounded,
              activeIcon: Icons.checklist_rounded,
              label: 'Tasks',
            ),
          ),
          Expanded(
            child: _NavItem(
              active: activeTab == AppNavTab.progress,
              tab: AppNavTab.progress,
              icon: Icons.insert_chart_outlined_rounded,
              activeIcon: Icons.insert_chart_rounded,
              label: 'Progress',
            ),
          ),
          Expanded(
            child: _NavItem(
              active: activeTab == AppNavTab.profile,
              tab: AppNavTab.profile,
              icon: Icons.person_outline_rounded,
              activeIcon: Icons.person_rounded,
              label: 'Profile',
            ),
          ),
        ],
      ),
    ),
  );
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.active,
    required this.tab,
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final bool active;
  final AppNavTab tab;
  final IconData icon;
  final IconData activeIcon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.sm),
      onTap: () => _navigate(context, tab),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: AppMotion.fastMs),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AnimatedScale(
              duration: const Duration(milliseconds: AppMotion.fastMs),
              scale: active ? 1.04 : 1,
              child: Icon(
                active ? activeIcon : icon,
                color: active
                    ? const Color(0xFF745CFF)
                    : const Color(0xFF7D86A8),
                size: 24,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 12.6,
                color: active
                    ? const Color(0xFF745CFF)
                    : const Color(0xFF7D86A8),
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: AppMotion.fastMs),
              height: 2.2,
              width: active ? 32 : 0,
              decoration: BoxDecoration(
                color: const Color(0xFF745CFF),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void _navigate(BuildContext context, AppNavTab tab) {
    switch (tab) {
      case AppNavTab.home:
        context.goNamed(AppRouteNames.home);
        return;
      case AppNavTab.tasks:
        context.goNamed(AppRouteNames.recoveryPaths);
        return;
      case AppNavTab.progress:
        context.goNamed(AppRouteNames.progressAnalytics);
        return;
      case AppNavTab.profile:
        context.goNamed(AppRouteNames.profile);
        return;
    }
  }
}
