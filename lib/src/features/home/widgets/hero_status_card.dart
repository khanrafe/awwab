import 'package:awwab/src/features/home/models/home_dashboard_model.dart';
import 'package:awwab/src/features/home/widgets/home_ui_tokens.dart';
import 'package:awwab/src/shared/widgets/animated_character_aura.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class HeroStatusCard extends StatelessWidget {
  const HeroStatusCard({
    super.key,
    required this.model,
    required this.isCompact,
  });

  final HomeDashboardModel model;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool shouldStack = constraints.maxWidth < 330;
        final bool compact = isCompact || constraints.maxWidth < 390;
        final double orbSize = compact ? 168 : 236;

        return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(HomeUiTokens.primaryCardRadius),
            boxShadow: AppShadows.card,
          ),
          child: Padding(
            padding: EdgeInsets.all(compact ? AppSpacing.sm : AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (shouldStack) ...<Widget>[
                  _leftInfo(textTheme, compact: compact),
                  const SizedBox(height: AppSpacing.sm),
                  Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: compact ? 176 : 220,
                      ),
                      child: _orb(progress: model.xpProgress, size: orbSize),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _rightInfo(textTheme, compact: compact),
                ] else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: compact ? 28 : 24,
                        child: _leftInfo(textTheme, compact: compact),
                      ),
                      SizedBox(width: compact ? AppSpacing.xs : AppSpacing.sm),
                      Expanded(
                        flex: compact ? 40 : 52,
                        child: Align(
                          alignment: Alignment.center,
                          child: _orb(
                            progress: model.xpProgress,
                            size: orbSize,
                          ),
                        ),
                      ),
                      SizedBox(width: compact ? AppSpacing.xs : AppSpacing.sm),
                      Expanded(
                        flex: compact ? 32 : 24,
                        child: _rightInfo(textTheme, compact: compact),
                      ),
                    ],
                  ),
                SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
                _xpSummary(textTheme, compact: compact),
                SizedBox(height: compact ? AppSpacing.xs : AppSpacing.sm),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: model.xpProgress),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, _) => ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: compact ? 7 : 8,
                      backgroundColor: const Color(0xFFE6E6F0),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        HomeUiTokens.accentViolet,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _leftInfo(TextTheme textTheme, {required bool compact}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        'AURA LEVEL',
        style: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: compact ? 10.5 : 11.5,
          letterSpacing: 0.2,
          color: const Color(0xFF8588A3),
        ),
      ),
      SizedBox(height: compact ? 6 : AppSpacing.xs),
      FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Text(
          '${model.auraLevel}',
          style: textTheme.headlineMedium?.copyWith(
            fontSize: compact ? 38 : 44,
            height: 1,
            color: HomeUiTokens.accentViolet,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      const SizedBox(height: 2),
      Text(
        'Ascendant',
        style: textTheme.titleMedium?.copyWith(
          color: const Color(0xFF6448E0),
          fontWeight: FontWeight.w700,
          fontSize: compact ? 13 : 14.5,
        ),
      ),
      SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
      DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFF7F5FF),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: 6,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.auto_awesome,
                size: 16,
                color: HomeUiTokens.accentViolet,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                model.rankLabel,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: compact ? 12.5 : 13.5,
                  color: const Color(0xFF5B4CCA),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  Widget _rightInfo(TextTheme textTheme, {required bool compact}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        'SYSTEM STATUS',
        style: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: compact ? 10.5 : 11.5,
          letterSpacing: 0.2,
          color: const Color(0xFF8588A3),
        ),
      ),
      SizedBox(height: compact ? 6 : AppSpacing.xs),
      Text(
        model.systemStatus,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: textTheme.titleMedium?.copyWith(
          fontSize: compact ? 14 : 15.5,
          color: const Color(0xFF3C4FC6),
          fontWeight: FontWeight.w800,
        ),
      ),
      SizedBox(height: compact ? 6 : AppSpacing.xs),
      Text(
        model.statusDescription,
        maxLines: compact ? 3 : 4,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodyMedium?.copyWith(
          height: 1.34,
          fontWeight: FontWeight.w600,
          fontSize: compact ? 12.5 : 13.5,
          color: HomeUiTokens.subtitleColor,
        ),
      ),
      SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.shield_rounded,
            color: const Color(0xFF4E89FF),
            size: compact ? 23 : 26,
          ),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Text(
              'Protection\nActive',
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: compact ? 12.8 : 13.8,
                color: const Color(0xFF3D4D7A),
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    ],
  );

  Widget _orb({required double progress, required double size}) => SizedBox(
    width: size,
    height: size,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: HomeUiTokens.softSurface,
            ),
          ),
        ),
        AnimatedCharacterAura(
          progress: progress,
          useProgressRing: false,
          size: size * 0.96,
        ),
      ],
    ),
  );

  Widget _xpSummary(
    TextTheme textTheme, {
    required bool compact,
  }) => LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth < 390) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                _xpHexBadge(),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    '${_formatNumber(model.xpCurrent)} / ${_formatNumber(model.xpTarget)} XP',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: compact ? 15.5 : 16.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Next Level: ${model.nextLevel}',
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: compact ? 13 : 14,
                color: HomeUiTokens.subtitleColor,
              ),
            ),
          ],
        );
      }

      return Row(
        children: <Widget>[
          _xpHexBadge(),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              '${_formatNumber(model.xpCurrent)} / ${_formatNumber(model.xpTarget)} XP',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: compact ? 16 : 17,
              ),
            ),
          ),
          Flexible(
            child: Text(
              'Next Level: ${model.nextLevel}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: compact ? 13 : 14,
                color: HomeUiTokens.subtitleColor,
              ),
            ),
          ),
        ],
      );
    },
  );

  Widget _xpHexBadge() => Container(
    width: 46,
    height: 46,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: <Color>[Color(0xFF6D56F7), Color(0xFF9A83FF)],
      ),
    ),
    child: const Center(
      child: Text(
        'XP',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 19,
          letterSpacing: 0.2,
        ),
      ),
    ),
  );

  String _formatNumber(int value) => value.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (m) => ',',
  );
}
