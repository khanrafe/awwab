import 'package:awwab/src/features/progress_analytics/models/progress_analytics_model.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class OverviewStatCard extends StatelessWidget {
  const OverviewStatCard({
    super.key,
    required this.stat,
    this.compact = false,
  });

  final OverviewStatModel stat;
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
            CircleAvatar(
              radius: compact ? 18 : 22,
              backgroundColor: stat.iconBg,
              child: Icon(stat.icon, color: stat.iconColor, size: compact ? 20 : 24),
            ),
            SizedBox(height: compact ? AppSpacing.xs : AppSpacing.sm),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                stat.value,
                style: textTheme.headlineMedium?.copyWith(
                  fontSize: compact ? 26 : 30,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF141D4B),
                  height: 1,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              stat.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF616B8D),
                fontWeight: FontWeight.w700,
                fontSize: compact ? 12.5 : 14,
              ),
            ),
            const Spacer(),
            Text(
              stat.delta,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF35B36A),
                fontWeight: FontWeight.w700,
                fontSize: compact ? 12 : 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
