import 'package:awwab/src/theme/app_motion.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppRadius.md),
      boxShadow: AppShadows.card,
    ),
    child: const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _NavItem(
              icon: Icons.home_filled,
              label: 'Home',
              active: true,
            ),
          ),
          Expanded(
            child: _NavItem(icon: Icons.checklist_rounded, label: 'Tasks'),
          ),
          Expanded(
            child: _NavItem(
              icon: Icons.insert_chart_outlined_rounded,
              label: 'Progress',
            ),
          ),
          Expanded(
            child: _NavItem(
              icon: Icons.person_outline_rounded,
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
    required this.icon,
    required this.label,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.sm),
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: AppMotion.fastMs),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AnimatedScale(
              duration: const Duration(milliseconds: AppMotion.fastMs),
              scale: active ? 1.03 : 1,
              child: Icon(
                icon,
                color: active
                    ? const Color(0xFF7558FF)
                    : const Color(0xFF8A91AF),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 12.6,
                color: active
                    ? const Color(0xFF7558FF)
                    : const Color(0xFF737C9E),
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: AppMotion.fastMs),
              height: 2.2,
              width: active ? 32 : 0,
              decoration: BoxDecoration(
                color: const Color(0xFF7558FF),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
