import 'package:awwab/src/features/log_action/data/log_action_mock_data.dart';
import 'package:awwab/src/features/log_action/models/log_action_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogActionState {
  const LogActionState({
    required this.model,
    this.selectedCategoryId,
    this.reflection = '',
    this.isSubmitting = false,
  });

  final LogActionScreenModel model;
  final String? selectedCategoryId;
  final String reflection;
  final bool isSubmitting;

  int get remainingCharacters => model.maxCharacters - reflection.length;

  LogActionState copyWith({
    String? selectedCategoryId,
    bool clearCategory = false,
    String? reflection,
    bool? isSubmitting,
  }) => LogActionState(
    model: model,
    selectedCategoryId: clearCategory
        ? null
        : (selectedCategoryId ?? this.selectedCategoryId),
    reflection: reflection ?? this.reflection,
    isSubmitting: isSubmitting ?? this.isSubmitting,
  );
}

class LogActionNotifier extends StateNotifier<LogActionState> {
  LogActionNotifier()
    : super(const LogActionState(model: LogActionMockData.model));

  void selectCategory(String id) {
    if (state.selectedCategoryId == id) {
      state = state.copyWith(clearCategory: true);
      return;
    }

    state = state.copyWith(selectedCategoryId: id);
  }

  void updateReflection(String value) {
    if (value.length > state.model.maxCharacters) {
      return;
    }
    state = state.copyWith(reflection: value);
  }

  Future<void> submit() async {
    state = state.copyWith(isSubmitting: true);
    await Future<void>.delayed(const Duration(milliseconds: 450));
    state = state.copyWith(isSubmitting: false);
  }
}

final logActionProvider =
    StateNotifierProvider<LogActionNotifier, LogActionState>(
      (ref) => LogActionNotifier(),
    );
