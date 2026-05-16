import 'package:awwab/src/features/progress_analytics/models/progress_analytics_model.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GrowthRadarCard extends StatelessWidget {
  const GrowthRadarCard({
    super.key,
    required this.areas,
    this.compact = false,
  });

  final List<GrowthAreaModel> areas;
  final bool compact;

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
        padding: EdgeInsets.all(compact ? AppSpacing.sm : AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'AREAS OF GROWTH',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: compact ? 17 : 20.8,
                color: const Color(0xFF141D4B),
              ),
            ),
            SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
            LayoutBuilder(
              builder: (context, constraints) {
                final bool stacked = constraints.maxWidth < 700;
                final Widget radar = SizedBox(
                  width: stacked ? double.infinity : constraints.maxWidth * 0.42,
                  height: compact ? 180 : 220,
                  child: RadarChart(
                    RadarChartData(
                      radarShape: RadarShape.polygon,
                      radarBorderData: const BorderSide(
                        color: Color(0xFFE8EAF4),
                        width: 1.1,
                      ),
                      tickCount: 5,
                      ticksTextStyle: const TextStyle(color: Colors.transparent),
                      tickBorderData: const BorderSide(
                        color: Color(0xFFECEFFA),
                        width: 1,
                      ),
                      gridBorderData: const BorderSide(
                        color: Color(0xFFECEFFA),
                        width: 1,
                      ),
                      titleTextStyle: TextStyle(
                        color: const Color(0xFF7A83A4),
                        fontSize: compact ? 11 : 12,
                        fontWeight: FontWeight.w700,
                      ),
                      getTitle: (index, angle) {
                        final GrowthAreaModel item = areas[index];
                        return RadarChartTitle(text: item.name, angle: angle);
                      },
                      dataSets: <RadarDataSet>[
                        RadarDataSet(
                          fillColor: const Color(0xFF7A5DFF).withValues(alpha: 0.28),
                          borderColor: const Color(0xFF7A5DFF),
                          borderWidth: 2.2,
                          entryRadius: compact ? 3.5 : 4,
                          dataEntries: areas
                              .map((e) => RadarEntry(value: e.percent.toDouble()))
                              .toList(),
                        ),
                      ],
                    ),
                    duration: const Duration(milliseconds: 700),
                  ),
                );

                final Widget bars = Column(
                  children: areas
                      .map((area) => _GrowthBarItem(area: area, compact: compact))
                      .toList(),
                );

                if (stacked) {
                  return Column(
                    children: <Widget>[
                      radar,
                      SizedBox(height: compact ? AppSpacing.xs : AppSpacing.sm),
                      bars,
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    radar,
                    const SizedBox(width: AppSpacing.md),
                    Expanded(child: bars),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _GrowthBarItem extends StatelessWidget {
  const _GrowthBarItem({
    required this.area,
    required this.compact,
  });

  final GrowthAreaModel area;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: compact ? AppSpacing.xs : AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(area.icon, size: compact ? 14 : 16, color: area.color),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  area.name,
                  style: textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF4E587D),
                    fontWeight: FontWeight.w700,
                    fontSize: compact ? 13 : null,
                  ),
                ),
              ),
              Text(
                '${area.percent}%',
                style: textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF2A3260),
                  fontWeight: FontWeight.w800,
                  fontSize: compact ? 13 : null,
                ),
              ),
            ],
          ),
          SizedBox(height: compact ? 3 : AppSpacing.xxs),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: area.percent / 100),
            duration: const Duration(milliseconds: 650),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) => ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: LinearProgressIndicator(
                value: value,
                minHeight: compact ? 5 : 6,
                backgroundColor: const Color(0xFFEAEAF5),
                valueColor: AlwaysStoppedAnimation<Color>(area.color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
