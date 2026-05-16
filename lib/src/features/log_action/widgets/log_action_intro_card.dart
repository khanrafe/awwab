import 'dart:math' as math;

import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class LogActionIntroCard extends StatelessWidget {
  const LogActionIntroCard({
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
        color: const Color(0xFFF9F7FF),
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
                      fontSize: 44 * 0.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    subtitle,
                    style: textTheme.bodyMedium?.copyWith(
                      height: 1.4,
                      fontSize: 36 * 0.42,
                      color: const Color(0xFF5C6486),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const _CharacterPlaceholder(),
          ],
        ),
      ),
    );
  }
}

class _CharacterPlaceholder extends StatelessWidget {
  const _CharacterPlaceholder();

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 168,
    height: 168,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        for (int i = 0; i < 3; i++)
          Transform.rotate(
            angle: (i + 1) * math.pi / 15,
            child: Container(
              width: 140 + (i * 16),
              height: 140 + (i * 16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(
                    0xFFDED7FF,
                  ).withValues(alpha: 0.65 - i * 0.15),
                ),
              ),
            ),
          ),
        Container(
          width: 114,
          height: 114,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: <Color>[
                const Color(0xFF8A7DFF).withValues(alpha: 0.25),
                const Color(0xFF3A3A86).withValues(alpha: 0.85),
              ],
            ),
          ),
        ),
        const Icon(Icons.person_rounded, color: Color(0xFF5959B9), size: 95),
        const Positioned(
          bottom: 40,
          child: Icon(Icons.auto_awesome, color: Color(0xFF9D8CFF), size: 28),
        ),
      ],
    ),
  );
}
