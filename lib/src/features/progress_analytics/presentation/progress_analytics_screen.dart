import 'package:awwab/src/features/progress_analytics/state/progress_analytics_state.dart';
import 'package:awwab/src/features/progress_analytics/widgets/aura_header_card.dart';
import 'package:awwab/src/features/progress_analytics/widgets/growth_radar_card.dart';
import 'package:awwab/src/features/progress_analytics/widgets/milestones_card.dart';
import 'package:awwab/src/features/progress_analytics/widgets/overview_stat_card.dart';
import 'package:awwab/src/features/progress_analytics/widgets/progress_bottom_nav.dart';
import 'package:awwab/src/features/progress_analytics/widgets/progress_line_chart_card.dart';
import 'package:awwab/src/features/progress_analytics/widgets/progress_top_bar.dart';
import 'package:awwab/src/theme/app_motion.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:awwab/src/widgets/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressAnalyticsScreen extends ConsumerWidget {
  const ProgressAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(progressAnalyticsProvider);
    final notifier = ref.read(progressAnalyticsProvider.notifier);
    final model = state.model;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);
    final bool compact = size.height < 780 || size.width < 390;

    return Scaffold(
      body: SafeArea(
        child: ResponsiveContainer(
          maxWidth: 1050,
          child: ListView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              compact ? AppSpacing.sm : AppSpacing.md,
              compact ? AppSpacing.sm : AppSpacing.md,
              compact ? AppSpacing.sm : AppSpacing.md,
              compact ? AppSpacing.sm : AppSpacing.md,
            ),
            children: <Widget>[
              ProgressTopBar(title: model.title, subtitle: model.subtitle)
                  .animate()
                  .fadeIn(duration: AppMotion.normalMs.ms)
                  .slideY(begin: 0.03),
              SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
              AuraHeaderCard(model: model, compact: compact)
                  .animate()
                  .fadeIn(delay: 60.ms, duration: AppMotion.slowMs.ms)
                  .slideY(begin: 0.04),
              SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
              Text(
                'OVERVIEW',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF141D4B),
                  fontSize: compact ? 16 : 18,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool fourAcross = constraints.maxWidth >= 680;
                  if (fourAcross) {
                    return SizedBox(
                      height: compact ? 164 : 180,
                      child: Row(
                        children: List<Widget>.generate(
                          model.overview.length,
                          (index) => Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: index == model.overview.length - 1
                                    ? 0
                                    : AppSpacing.sm,
                              ),
                              child: OverviewStatCard(
                                stat: model.overview[index],
                                compact: compact,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: model.overview.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: AppSpacing.sm,
                          mainAxisSpacing: AppSpacing.sm,
                          childAspectRatio: 1.55,
                        ),
                    itemBuilder: (context, index) => OverviewStatCard(
                      stat: model.overview[index],
                      compact: true,
                    ),
                  );
                },
              ).animate().fadeIn(
                delay: 110.ms,
                duration: AppMotion.normalMs.ms,
              ),
              SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
              ProgressLineChartCard(
                points: model.dailyProgress,
                selectedIndex: state.selectedPoint,
                period: state.period,
                onSelect: notifier.selectPoint,
                compact: compact,
              ).animate().fadeIn(
                delay: 170.ms,
                duration: AppMotion.normalMs.ms,
              ),
              SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
              GrowthRadarCard(areas: model.growthAreas, compact: compact)
                  .animate()
                  .fadeIn(delay: 220.ms, duration: AppMotion.normalMs.ms),
              SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
              MilestonesCard(items: model.milestones, compact: compact)
                  .animate()
                  .fadeIn(delay: 260.ms, duration: AppMotion.normalMs.ms),
              SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
              const ProgressBottomNav().animate().fadeIn(
                delay: 300.ms,
                duration: AppMotion.normalMs.ms,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
