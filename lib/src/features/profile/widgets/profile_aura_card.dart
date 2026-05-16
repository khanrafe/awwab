import 'package:awwab/src/features/profile/models/profile_model.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class ProfileAuraCard extends StatelessWidget {
  const ProfileAuraCard({
    super.key,
    required this.model,
    required this.compact,
  });

  final ProfileModel model;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF131A6C),
            Color(0xFF3D35B5),
            Color(0xFF6B4FFF),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(compact ? AppSpacing.sm : AppSpacing.md),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'AURA LEVEL',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: compact ? 6 : AppSpacing.xs),
                  Wrap(
                    spacing: AppSpacing.xs,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      Text(
                        'Lv. ${model.level}',
                        style: textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        model.levelTitle,
                        style: textTheme.titleLarge?.copyWith(
                          color: const Color(0xFF9E89FF),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: compact ? AppSpacing.xs : AppSpacing.sm),
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: model.auraProgress),
                    duration: const Duration(milliseconds: 700),
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
                  SizedBox(height: compact ? 6 : AppSpacing.xs),
                  Text(
                    '${_format(model.currentXp)} / ${_format(model.targetXp)} XP',
                    style: textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: compact ? AppSpacing.sm : AppSpacing.md),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.shield_moon_rounded,
                  color: const Color(0xFFD4C7FF),
                  size: compact ? 46 : 54,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'View Aura',
                  style: textTheme.titleMedium?.copyWith(
                    color: const Color(0xFFE1D8FF),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _format(int value) => value.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (m) => ',',
  );
}
