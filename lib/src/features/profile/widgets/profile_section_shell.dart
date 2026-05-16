import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class ProfileSectionShell extends StatelessWidget {
  const ProfileSectionShell({
    super.key,
    required this.title,
    this.trailing,
    required this.child,
    required this.compact,
  });

  final String title;
  final String? trailing;
  final Widget child;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: AppShadows.soft,
      ),
      child: Padding(
        padding: EdgeInsets.all(compact ? AppSpacing.sm : AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  title,
                  style: textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF141D4B),
                    fontWeight: FontWeight.w800,
                    fontSize: compact ? 26 * 0.47 : 30 * 0.47,
                  ),
                ),
                const Spacer(),
                if (trailing != null)
                  Text(
                    trailing!,
                    style: textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF7A5DFF),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                if (trailing != null) const SizedBox(width: 4),
                if (trailing != null)
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13,
                    color: Color(0xFF7A5DFF),
                  ),
              ],
            ),
            SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
            child,
          ],
        ),
      ),
    );
  }
}
