import 'dart:math' as math;

import 'package:awwab/src/features/home/models/home_dashboard_model.dart';
import 'package:awwab/src/features/home/widgets/home_ui_tokens.dart';
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

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(HomeUiTokens.primaryCardRadius),
        boxShadow: AppShadows.card,
      ),
      child: Padding(
        padding: EdgeInsets.all(
          isCompact
              ? HomeUiTokens.compactCardPadding
              : HomeUiTokens.cardPadding,
        ),
        child: Column(
          children: <Widget>[
            isCompact
                ? Column(
                    children: <Widget>[
                      _leftInfo(textTheme),
                      const SizedBox(height: AppSpacing.md),
                      _orb(),
                      const SizedBox(height: AppSpacing.md),
                      _rightInfo(textTheme),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child: _leftInfo(textTheme)),
                      Expanded(flex: 2, child: _orb()),
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
  }

  Widget _leftInfo(TextTheme textTheme) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
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
      Text(
        '${model.auraLevel}',
        style: textTheme.headlineMedium?.copyWith(
          fontSize: 47,
          height: 1,
          color: HomeUiTokens.accentViolet,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 2),
      Text(
        'Ascendant',
        style: textTheme.titleMedium?.copyWith(
          color: const Color(0xFF6448E0),
          fontWeight: FontWeight.w700,
          fontSize: 32 * 0.55,
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
        style: textTheme.titleMedium?.copyWith(
          fontSize: 18,
          color: const Color(0xFF3C4FC6),
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: AppSpacing.sm),
      Text(
        model.statusDescription,
        style: textTheme.bodyMedium?.copyWith(
          height: 1.4,
          fontWeight: FontWeight.w600,
          color: HomeUiTokens.subtitleColor,
        ),
      ),
      const SizedBox(height: AppSpacing.lg),
      Row(
        children: <Widget>[
          const Icon(
            Icons.verified_user_rounded,
            color: Color(0xFF4E89FF),
            size: 30,
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
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

  Widget _orb() => AspectRatio(
    aspectRatio: 1,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: SweepGradient(
              colors: <Color>[
                Color(0xFFA97CFF),
                Color(0xFFB1D0FF),
                Color(0xFF9E7AFF),
                Color(0xFFA97CFF),
              ],
              transform: GradientRotation(math.pi / 8),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0x338A63FF),
                blurRadius: 24,
                offset: Offset(0, 10),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: HomeUiTokens.softSurface,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: <Color>[
                const Color(0xFF2B2B66).withValues(alpha: 0.25),
                const Color(0xFF15153A).withValues(alpha: 0.92),
              ],
            ),
          ),
        ),
        const Icon(Icons.person_rounded, color: Color(0xFF0E1140), size: 140),
        const Positioned(
          bottom: 48,
          child: Icon(Icons.auto_awesome, color: Color(0xFF7A63FF), size: 34),
        ),
      ],
    ),
  );

  Widget _xpSummary(TextTheme textTheme) => LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth < 330) {
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
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          Text(
            'Next Level: ${model.nextLevel}',
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: HomeUiTokens.subtitleColor,
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
