import 'dart:math' as math;

import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class RecoveryPathsHeroCard extends StatelessWidget {
  const RecoveryPathsHeroCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

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
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF6D5CFF),
                      fontWeight: FontWeight.w800,
                      fontSize: 18.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    subtitle,
                    style: textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF5C6486),
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F4FF),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(
                          Icons.shield_rounded,
                          color: Color(0xFF8A73FF),
                          size: 18,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          'Protected Space',
                          style: textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF6C6493),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const _HeroIllustration(),
          ],
        ),
      ),
    );
  }
}

class _HeroIllustration extends StatelessWidget {
  const _HeroIllustration();

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 190,
    height: 190,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 175,
          height: 175,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: SweepGradient(
              colors: <Color>[
                Color(0xFFB99DFF),
                Color(0xFFDBECFF),
                Color(0xFF9E80FF),
                Color(0xFFB99DFF),
              ],
              transform: GradientRotation(math.pi / 12),
            ),
          ),
        ),
        Container(
          width: 154,
          height: 154,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFFAFAFF),
          ),
        ),
        Container(
          width: 124,
          height: 124,
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
        const Icon(Icons.person_rounded, color: Color(0xFF1E216A), size: 126),
        const Positioned(
          bottom: 40,
          child: Icon(Icons.auto_awesome, color: Color(0xFF8F7BFF), size: 26),
        ),
      ],
    ),
  );
}
