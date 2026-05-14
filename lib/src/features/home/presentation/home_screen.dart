import 'package:awwab/src/core/responsive_breakpoints.dart';
import 'package:awwab/src/features/home/data/home_mock_data.dart';
import 'package:awwab/src/features/home/models/home_dashboard_model.dart';
import 'package:awwab/src/features/home/widgets/hero_status_card.dart';
import 'package:awwab/src/features/home/widgets/home_bottom_nav.dart';
import 'package:awwab/src/features/home/widgets/home_header.dart';
import 'package:awwab/src/features/home/widgets/home_ui_tokens.dart';
import 'package:awwab/src/features/home/widgets/metric_card.dart';
import 'package:awwab/src/features/home/widgets/quest_card.dart';
import 'package:awwab/src/features/home/widgets/quick_action_card.dart';
import 'package:awwab/src/features/home/widgets/quote_banner.dart';
import 'package:awwab/src/theme/app_motion.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:awwab/src/widgets/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const model = HomeMockData.dashboard;
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final bool isTablet = ResponsiveBreakpoints.isTabletOrLarger(context);
    final bool isCompact = size.width < 355;
    final double horizontalPadding = HomeUiTokens.screenHorizontalPadding(
      size.width,
    );
    final double headingScale = HomeUiTokens.headingScale(
      mediaQuery.textScaler.scale(1),
    );

    return Scaffold(
      body: SafeArea(
        child: ResponsiveContainer(
          maxWidth: 940,
          child: ListView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              isTablet ? AppSpacing.lg : AppSpacing.md,
              horizontalPadding,
              AppSpacing.md,
            ),
            children: <Widget>[
              const HomeHeader()
                  .animate()
                  .fadeIn(duration: AppMotion.normalMs.ms)
                  .slideY(begin: 0.04, end: 0),
              const SizedBox(height: HomeUiTokens.sectionGap),
              RepaintBoundary(
                child: HeroStatusCard(model: model, isCompact: isCompact)
                    .animate()
                    .fadeIn(
                      delay: HomeUiTokens.pageStaggerStepMs.ms,
                      duration: AppMotion.slowMs.ms,
                    )
                    .slideY(begin: 0.06, end: 0),
              ),
              const SizedBox(height: HomeUiTokens.sectionGap),
              _MetricsSection(metrics: model.metrics).animate().fadeIn(
                delay: (2 * HomeUiTokens.pageStaggerStepMs).ms,
                duration: AppMotion.normalMs.ms,
              ),
              const SizedBox(height: HomeUiTokens.sectionGap),
              QuestCard(quest: model.quest)
                  .animate()
                  .fadeIn(
                    delay: (3 * HomeUiTokens.pageStaggerStepMs).ms,
                    duration: AppMotion.normalMs.ms,
                  )
                  .slideY(begin: 0.03, end: 0),
              const SizedBox(height: HomeUiTokens.sectionGapLarge),
              Text(
                'QUICK ACTIONS',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 13.2 * headingScale,
                  letterSpacing: 0.2,
                  color: HomeUiTokens.titleColor,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              _QuickActionsSection(
                actions: model.quickActions,
              ).animate().fadeIn(
                delay: (4 * HomeUiTokens.pageStaggerStepMs).ms,
                duration: AppMotion.normalMs.ms,
              ),
              const SizedBox(height: HomeUiTokens.sectionGap),
              QuoteBanner(quote: model.quote).animate().fadeIn(
                delay: (5 * HomeUiTokens.pageStaggerStepMs).ms,
                duration: AppMotion.normalMs.ms,
              ),
              const SizedBox(height: AppSpacing.md),
              const HomeBottomNav().animate().fadeIn(
                delay: (6 * HomeUiTokens.pageStaggerStepMs).ms,
                duration: AppMotion.normalMs.ms,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricsSection extends StatelessWidget {
  const _MetricsSection({required this.metrics});

  final List<StatusMetricModel> metrics;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final bool threeColumns = constraints.maxWidth >= 340;

      if (threeColumns) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: MetricCard(metric: metrics[0])),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: MetricCard(metric: metrics[1])),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: MetricCard(metric: metrics[2])),
          ],
        );
      }

      return Column(
        children: metrics
            .map(
              (metric) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: MetricCard(metric: metric),
              ),
            )
            .toList(),
      );
    },
  );
}

class _QuickActionsSection extends StatelessWidget {
  const _QuickActionsSection({required this.actions});

  final List<QuickActionModel> actions;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final bool threeColumns = constraints.maxWidth >= 360;

      if (threeColumns) {
        return SizedBox(
          height: constraints.maxWidth >= 700 ? 214 : 198,
          child: Row(
            children: <Widget>[
              Expanded(child: QuickActionCard(action: actions[0])),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: QuickActionCard(action: actions[1])),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: QuickActionCard(action: actions[2])),
            ],
          ),
        );
      }

      return Column(
        children: actions
            .map(
              (action) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: AspectRatio(
                  aspectRatio: 1.9,
                  child: QuickActionCard(action: action),
                ),
              ),
            )
            .toList(),
      );
    },
  );
}
