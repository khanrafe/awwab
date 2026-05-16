import 'package:awwab/src/features/progress_analytics/models/progress_analytics_model.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProgressLineChartCard extends StatelessWidget {
  const ProgressLineChartCard({
    super.key,
    required this.points,
    required this.selectedIndex,
    required this.period,
    required this.onSelect,
    this.compact = false,
  });

  final List<DailyProgressPoint> points;
  final int selectedIndex;
  final String period;
  final ValueChanged<int> onSelect;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final DailyProgressPoint selected = points[selectedIndex];

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
            Row(
              children: <Widget>[
                Text(
                  'PROGRESS OVER TIME',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: compact ? 17 : 20.8,
                    color: const Color(0xFF141D4B),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F3FF),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        period,
                        style: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF232C57),
                          fontSize: compact ? 12.5 : null,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: Color(0xFF7B63FF),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
            SizedBox(
              height: compact ? 176 : 220,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: 100,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 25,
                    getDrawingHorizontalLine: (value) =>
                        const FlLine(color: Color(0xFFEDEEFA), strokeWidth: 1),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: compact ? 24 : 28,
                        getTitlesWidget: (value, meta) => Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            fontSize: compact ? 11 : 12,
                            color: const Color(0xFF9AA2BE),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final int idx = value.toInt();
                          if (idx < 0 || idx >= points.length) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              points[idx].day,
                              style: TextStyle(
                                fontSize: compact ? 11.5 : 13,
                                color: const Color(0xFF7F88AA),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineTouchData: LineTouchData(
                    enabled: true,
                    handleBuiltInTouches: true,
                    touchCallback: (event, response) {
                      final touched = response?.lineBarSpots?.firstOrNull;
                      if (touched != null) {
                        onSelect(touched.x.toInt());
                      }
                    },
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (spots) => spots
                          .map(
                            (spot) => LineTooltipItem(
                              '${points[spot.x.toInt()].day}\n${spot.y.toInt()}%',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  lineBarsData: <LineChartBarData>[
                    LineChartBarData(
                      isCurved: true,
                      curveSmoothness: 0.3,
                      spots: points
                          .asMap()
                          .entries
                          .map((e) => FlSpot(e.key.toDouble(), e.value.value))
                          .toList(),
                      color: const Color(0xFF7A5DFF),
                      barWidth: 3.5,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            const Color(0xFF7A5DFF).withValues(alpha: 0.2),
                            const Color(0xFF7A5DFF).withValues(alpha: 0.01),
                          ],
                        ),
                      ),
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, p1, p2, p3) {
                          final bool active = spot.x.toInt() == selectedIndex;
                          return FlDotCirclePainter(
                            radius: active ? 6 : 4.5,
                            color: const Color(0xFF7A5DFF),
                            strokeColor: Colors.white,
                            strokeWidth: 2,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                duration: const Duration(milliseconds: 700),
              ),
            ),
            SizedBox(height: compact ? AppSpacing.xs : AppSpacing.sm),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF171A59),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(
                  '${selected.day} ${selected.value.toInt()}%',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
