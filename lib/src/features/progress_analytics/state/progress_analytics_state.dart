import 'package:awwab/src/features/progress_analytics/data/progress_analytics_mock_data.dart';
import 'package:awwab/src/features/progress_analytics/models/progress_analytics_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressAnalyticsState {
  const ProgressAnalyticsState({
    required this.model,
    required this.selectedPoint,
    required this.period,
  });

  final ProgressAnalyticsModel model;
  final int selectedPoint;
  final String period;

  ProgressAnalyticsState copyWith({int? selectedPoint, String? period}) =>
      ProgressAnalyticsState(
        model: model,
        selectedPoint: selectedPoint ?? this.selectedPoint,
        period: period ?? this.period,
      );
}

class ProgressAnalyticsNotifier extends StateNotifier<ProgressAnalyticsState> {
  ProgressAnalyticsNotifier()
    : super(
        const ProgressAnalyticsState(
          model: ProgressAnalyticsMockData.model,
          selectedPoint: 6,
          period: 'This Week',
        ),
      );

  void selectPoint(int index) {
    state = state.copyWith(selectedPoint: index);
  }

  void changePeriod(String value) {
    state = state.copyWith(period: value);
  }
}

final progressAnalyticsProvider =
    StateNotifierProvider<ProgressAnalyticsNotifier, ProgressAnalyticsState>(
      (ref) => ProgressAnalyticsNotifier(),
    );
