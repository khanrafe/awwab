import 'package:awwab/src/features/progress_analytics/models/progress_analytics_model.dart';
import 'package:awwab/src/shared/widgets/animated_character_aura.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class AuraHeaderCard extends StatelessWidget {
  const AuraHeaderCard({super.key, required this.model, this.compact = false});

  final ProgressAnalyticsModel model;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF121A6E),
            Color(0xFF3E37B4),
            Color(0xFF6A4EFF),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(compact ? AppSpacing.sm : AppSpacing.md),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool stack = constraints.maxWidth < 560;
            final Widget content = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'AURA LEVEL',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.88),
                    fontWeight: FontWeight.w700,
                    fontSize: compact ? 12 : 14,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Lv. ${model.auraLevel}',
                  style: textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: compact ? 34 : 38,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  model.auraStatus,
                  style: textTheme.titleMedium?.copyWith(
                    color: const Color(0xFFA994FF),
                    fontWeight: FontWeight.w800,
                    fontSize: compact ? 18 : 20,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  '${_format(model.xpCurrent)} / ${_format(model.xpTarget)} XP',
                  style: textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: compact ? 18 : 20,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: model.auraProgress),
                  duration: const Duration(milliseconds: 750),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) => ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: compact ? 6 : 8,
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF8A73FF),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${_format(model.xpToNext)} XP to next level',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w600,
                    fontSize: compact ? 12.5 : 14,
                  ),
                ),
              ],
            );

            if (stack) {
              return Column(
                children: <Widget>[
                  content,
                  const SizedBox(height: AppSpacing.sm),
                  _AuraFigure(compact: true, progress: model.auraProgress),
                ],
              );
            }

            return Row(
              children: <Widget>[
                Expanded(child: content),
                const SizedBox(width: AppSpacing.sm),
                _AuraFigure(compact: compact, progress: model.auraProgress),
              ],
            );
          },
        ),
      ),
    );
  }

  String _format(int value) => value.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (m) => ',',
  );
}

class _AuraFigure extends StatelessWidget {
  const _AuraFigure({required this.compact, required this.progress});

  final bool compact;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final double w = compact ? 170 : 220;
    final double h = compact ? 150 : 190;
    return SizedBox(
      width: w,
      height: h,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          AnimatedCharacterAura(progress: progress, size: compact ? 150 : 188),
        ],
      ),
    );
  }
}
