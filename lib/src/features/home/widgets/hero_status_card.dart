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
        final bool shouldStack = isCompact || constraints.maxWidth < 620;

        return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(HomeUiTokens.primaryCardRadius),
            boxShadow: AppShadows.card,
          ),
          child: Padding(
            padding: EdgeInsets.all(
              shouldStack
                  ? HomeUiTokens.compactCardPadding
                  : HomeUiTokens.cardPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (shouldStack) ...<Widget>[
                  _leftInfo(textTheme),
                  const SizedBox(height: AppSpacing.md),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 312),
                      child: _orb(progress: model.xpProgress),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _rightInfo(textTheme),
                ] else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child: _leftInfo(textTheme)),
                      Expanded(
                        flex: 2,
                        child: _orb(progress: model.xpProgress),
                      ),
                      Expanded(child: _rightInfo(textTheme)),
                    ],
                  ),
                const SizedBox(height: AppSpacing.md),
                _xpSummary(textTheme),
                const SizedBox(height: AppSpacing.sm),
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: model.xpProgress),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, _) => ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: 8,
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

  Widget _leftInfo(TextTheme textTheme) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        'AURA LEVEL',
        style: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 12,
          letterSpacing: 0.2,
          color: const Color(0xFF8588A3),
        ),
      ),
      const SizedBox(height: AppSpacing.sm),
      FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Text(
          '${model.auraLevel}',
          style: textTheme.headlineMedium?.copyWith(
            fontSize: 49,
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
          fontSize: 18,
        ),
      ),
      const SizedBox(height: AppSpacing.md),
      DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFF7F5FF),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
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
                  color: const Color(0xFF5B4CCA),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  Widget _rightInfo(TextTheme textTheme) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        'SYSTEM STATUS',
        style: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 12,
          letterSpacing: 0.2,
          color: const Color(0xFF8588A3),
        ),
      ),
      const SizedBox(height: AppSpacing.sm),
      Text(
        model.systemStatus,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: textTheme.titleMedium?.copyWith(
          fontSize: 19,
          color: const Color(0xFF3C4FC6),
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: AppSpacing.sm),
      Text(
        model.statusDescription,
        style: textTheme.bodyMedium?.copyWith(
          height: 1.34,
          fontWeight: FontWeight.w600,
          color: HomeUiTokens.subtitleColor,
        ),
      ),
      const SizedBox(height: AppSpacing.lg),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.shield_rounded, color: Color(0xFF4E89FF), size: 30),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Text(
              'Protection\nActive',
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF3D4D7A),
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    ],
  );

  Widget _orb({required double progress}) => AspectRatio(
    aspectRatio: 1,
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
        AnimatedCharacterAura(progress: progress, size: 228),
      ],
    ),
  );

  Widget _xpSummary(TextTheme textTheme) => LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth < 390) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                _xpPill(),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    '${_formatNumber(model.xpCurrent)} / ${_formatNumber(model.xpTarget)} XP',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
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
                color: HomeUiTokens.subtitleColor,
              ),
            ),
          ],
        );
      }

      return Row(
        children: <Widget>[
          _xpPill(),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              '${_formatNumber(model.xpCurrent)} / ${_formatNumber(model.xpTarget)} XP',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18,
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
                color: HomeUiTokens.subtitleColor,
              ),
            ),
          ),
        ],
      );
    },
  );

  Widget _xpPill() => DecoratedBox(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFF7356FF), Color(0xFF947DFF)],
      ),
      borderRadius: BorderRadius.circular(AppRadius.sm),
    ),
    child: const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      child: Text(
        'XP',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
      ),
    ),
  );

  String _formatNumber(int value) => value.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (m) => ',',
  );
}
