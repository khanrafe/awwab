import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class PathStepTopBar extends StatelessWidget {
  const PathStepTopBar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onBack,
  });

  final String title;
  final String subtitle;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _IconSurface(icon: Icons.arrow_back_rounded, onTap: onBack),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Column(
              children: <Widget>[
                Text(
                  title,
                  style: textTheme.headlineMedium?.copyWith(
                    fontSize: 48 * 0.55,
                    color: const Color(0xFF111A47),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    height: 1.3,
                    fontSize: 16 * 0.86,
                    color: const Color(0xFF616C8F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        const _IconSurface(
          icon: Icons.local_fire_department_rounded,
          iconColor: Color(0xFF6952FF),
        ),
      ],
    );
  }
}

class _IconSurface extends StatelessWidget {
  const _IconSurface({
    required this.icon,
    this.iconColor = const Color(0xFF1D295C),
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(AppRadius.md),
    child: InkWell(
      borderRadius: BorderRadius.circular(AppRadius.md),
      onTap: onTap,
      child: Ink(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.md),
          boxShadow: AppShadows.soft,
        ),
        child: Icon(icon, color: iconColor, size: 30),
      ),
    ),
  );
}
