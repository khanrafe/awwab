import 'package:awwab/src/core/responsive_breakpoints.dart';
import 'package:awwab/src/features/home/data/home_mock_data.dart';
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
    final bool isCompact = size.width < 390;
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
                      delay: 1.ms * HomeUiTokens.pageStaggerStepMs,
                      duration: AppMotion.slowMs.ms,
                    )
                    .slideY(begin: 0.06, end: 0),
              ),
              const SizedBox(height: HomeUiTokens.sectionGap),
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool threeColumns = constraints.maxWidth >= 640;
                  if (threeColumns) {
                    return Row(
                      children: <Widget>[
                        Expanded(child: MetricCard(metric: model.metrics[0])),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(child: MetricCard(metric: model.metrics[1])),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(child: MetricCard(metric: model.metrics[2])),
                      ],
                    );
                  }

                  return Column(
                    children: model.metrics
                        .map(
                          (metric) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.sm,
                            ),
                            child: SizedBox(
                              height: isCompact ? 188 : 200,
                              child: MetricCard(metric: metric),
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ).animate().fadeIn(
                delay: 2.ms * HomeUiTokens.pageStaggerStepMs,
                duration: AppMotion.normalMs.ms,
              ),
              const SizedBox(height: HomeUiTokens.sectionGap),
              QuestCard(quest: model.quest)
                  .animate()
                  .fadeIn(
                    delay: 3.ms * HomeUiTokens.pageStaggerStepMs,
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
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool threeColumns = constraints.maxWidth >= 700;
                  final bool twoColumns = constraints.maxWidth >= 470;

                  if (threeColumns) {
                    return SizedBox(
                      height: 210,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: QuickActionCard(
                              action: model.quickActions[0],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: QuickActionCard(
                              action: model.quickActions[1],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: QuickActionCard(
                              action: model.quickActions[2],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (twoColumns) {
                    return Wrap(
                      runSpacing: AppSpacing.sm,
                      spacing: AppSpacing.sm,
                      children: model.quickActions
                          .map(
                            (action) => SizedBox(
                              width: (constraints.maxWidth - AppSpacing.sm) / 2,
                              height: 188,
                              child: QuickActionCard(action: action),
                            ),
                          )
                          .toList(),
                    );
                  }

                  return Column(
                    children: model.quickActions
                        .map(
                          (action) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.sm,
                            ),
                            child: SizedBox(
                              height: 180,
                              child: QuickActionCard(action: action),
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ).animate().fadeIn(
                delay: 4.ms * HomeUiTokens.pageStaggerStepMs,
                duration: AppMotion.normalMs.ms,
              ),
              const SizedBox(height: HomeUiTokens.sectionGap),
              QuoteBanner(quote: model.quote).animate().fadeIn(
                delay: 5.ms * HomeUiTokens.pageStaggerStepMs,
                duration: AppMotion.normalMs.ms,
              ),
              const SizedBox(height: AppSpacing.md),
              const HomeBottomNav().animate().fadeIn(
                delay: 6.ms * HomeUiTokens.pageStaggerStepMs,
                duration: AppMotion.normalMs.ms,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
