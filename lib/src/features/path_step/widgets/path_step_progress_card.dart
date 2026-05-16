import 'dart:math' as math;

import 'package:awwab/src/features/path_step/models/path_step_model.dart';
import 'package:awwab/src/features/path_step/widgets/path_progress_pill_row.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class PathStepProgressCard extends StatelessWidget {
  const PathStepProgressCard({
    super.key,
    required this.journey,
    required this.currentIndex,
    required this.completionPercent,
    required this.totalXp,
  });

  final RecoveryJourneyModel journey;
  final int currentIndex;
  final double completionPercent;
  final int totalXp;

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
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: 74,
                            height: 74,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF3EFFF),
                            ),
                            child: Icon(
                              Icons.spa_rounded,
                              color: journey.pathAccent,
                              size: 40,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  journey.pathName,
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 43 * 0.52,
                                    color: const Color(0xFF131C4A),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.xxs),
                                Text(
                                  'Step ${currentIndex + 1} of ${journey.totalSteps}',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: const Color(0xFF7A83A4),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: completionPercent),
                        duration: const Duration(milliseconds: 650),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, _) => PathProgressPillRow(
                          total: journey.totalSteps,
                          current: math.max(
                            1,
                            (value * journey.totalSteps).round(),
                          ),
                          accent: journey.pathAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const _CharacterRing(),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            const Divider(color: Color(0xFFEAEAF6), height: 1),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: <Widget>[
                Expanded(
                  child: _MetaItem(
                    icon: Icons.trending_up_rounded,
                    title: '${(completionPercent * 100).round()}%',
                    subtitle: 'Journey progress',
                  ),
                ),
                Container(width: 1, height: 50, color: const Color(0xFFE8EAF4)),
                Expanded(
                  child: _MetaItem(
                    icon: Icons.auto_awesome,
                    title: '$totalXp XP',
                    subtitle: 'Earned so far',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xFFF3F4FF),
            child: Icon(icon, size: 17, color: const Color(0xFF785CFF)),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 32 * 0.52,
                  color: const Color(0xFF131C4A),
                ),
              ),
              Text(
                subtitle,
                style: textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF7A83A4),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CharacterRing extends StatelessWidget {
  const _CharacterRing();

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 205,
    height: 205,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 188,
          height: 188,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: SweepGradient(
              colors: <Color>[
                Color(0xFFB99DFF),
                Color(0xFFDBECFF),
                Color(0xFF9E80FF),
                Color(0xFFB99DFF),
              ],
              transform: GradientRotation(math.pi / 11),
            ),
          ),
        ),
        Container(
          width: 166,
          height: 166,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFFAFAFF),
          ),
        ),
        Container(
          width: 132,
          height: 132,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: <Color>[
                const Color(0xFFBDB3FF).withValues(alpha: 0.35),
                const Color(0xFF2F2F8E).withValues(alpha: 0.9),
              ],
            ),
          ),
        ),
        const Icon(Icons.person_rounded, color: Color(0xFF1E216A), size: 124),
        const Positioned(
          bottom: 44,
          child: Icon(Icons.auto_awesome, color: Color(0xFF8F7BFF), size: 26),
        ),
      ],
    ),
  );
}
