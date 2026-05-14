import 'package:awwab/src/constants/app_constants.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:awwab/src/widgets/app_scaffold.dart';
import 'package:awwab/src/widgets/responsive_container.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppScaffold(
      title: AppConstants.appName,
      body: ResponsiveContainer(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: <Widget>[
            Text(
              'Scalable Flutter Foundation',
              style: textTheme.headlineMedium,
            ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.15),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Riverpod, GoRouter, Hive, Material 3, and reusable theming are configured and ready.',
              style: textTheme.bodyMedium,
            ).animate().fadeIn(delay: 120.ms, duration: 320.ms),
            const SizedBox(height: AppSpacing.lg),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Starter Metrics', style: textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.md),
                    SizedBox(
                      height: 180,
                      child: BarChart(
                        BarChartData(
                          titlesData: const FlTitlesData(show: false),
                          gridData: const FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          barGroups: <BarChartGroupData>[
                            _bar(0, 4),
                            _bar(1, 6),
                            _bar(2, 8),
                            _bar(3, 7),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 180.ms, duration: 320.ms).scale(begin: const Offset(0.98, 0.98)),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _bar(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: <BarChartRodData>[
        BarChartRodData(
          toY: y,
          width: 18,
          borderRadius: BorderRadius.circular(6),
          color: const Color(0xFF0B6E4F),
        ),
      ],
    );
  }
}
