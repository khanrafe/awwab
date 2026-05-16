import 'package:awwab/src/features/log_action/models/log_action_model.dart';
import 'package:awwab/src/theme/app_motion.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class LogActionCategoryCard extends StatelessWidget {
  const LogActionCategoryCard({
    super.key,
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final LogActionCategoryModel category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: selected ? 1 : 0),
      duration: const Duration(milliseconds: AppMotion.fastMs),
      curve: Curves.easeOutCubic,
      builder: (context, t, _) {
        final Color borderColor = Color.lerp(
          const Color(0xFFE9E9F4),
          category.accent.withValues(alpha: 0.70),
          t,
        )!;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.md),
            onTap: onTap,
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: borderColor, width: 1.2),
                boxShadow: AppShadows.soft,
              ),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.lerp(
                        category.softBackground,
                        category.accent.withValues(alpha: 0.14),
                        t,
                      ),
                    ),
                    child: Icon(
                      category.icon,
                      size: 46,
                      color: category.accent,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    category.title,
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 15.2,
                      color: const Color(0xFF151E4C),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    category.subtitle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF626D90),
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
