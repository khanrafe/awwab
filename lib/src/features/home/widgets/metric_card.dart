import 'package:awwab/src/features/home/models/home_dashboard_model.dart';
import 'package:awwab/src/features/home/widgets/home_ui_tokens.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  const MetricCard({super.key, required this.metric});

  final StatusMetricModel metric;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double ringSize = constraints.maxWidth.clamp(84, 112);

        return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow: AppShadows.soft,
          ),
          child: Padding(
            padding: const EdgeInsets.all(HomeUiTokens.cardPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  metric.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF2E3457),
                    fontSize: 13,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                SizedBox(
                  width: ringSize,
                  height: ringSize,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      begin: 0,
                      end: metric.progress.clamp(0, 1),
                    ),
                    duration: const Duration(milliseconds: 620),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) => CircularProgressIndicator(
                      value: value,
                      strokeWidth: 5,
                      color: metric.color,
                      backgroundColor: metric.color.withValues(alpha: 0.16),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${metric.value}',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 32,
                      color: HomeUiTokens.titleColor,
                      height: 1.05,
                    ),
                  ),
                ),
                Text(
                  metric.unit,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: HomeUiTokens.subtitleColor,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: LinearProgressIndicator(
                    value: metric.progress.clamp(0, 1),
                    minHeight: 6,
                    backgroundColor: const Color(0xFFE9EAF2),
                    valueColor: AlwaysStoppedAnimation<Color>(metric.color),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
