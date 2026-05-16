import 'package:awwab/src/features/path_step/data/path_step_mock_data.dart';
import 'package:awwab/src/features/path_step/models/path_step_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PathStepState {
  const PathStepState({
    required this.journey,
    required this.currentIndex,
    required this.reflections,
    required this.completedSteps,
    required this.savedSteps,
    required this.taskProgress,
    required this.isCompleting,
    required this.isSaving,
  });

  final RecoveryJourneyModel journey;
  final int currentIndex;
  final Map<String, String> reflections;
  final Set<String> completedSteps;
  final Set<String> savedSteps;
  final Map<String, int> taskProgress;
  final bool isCompleting;
  final bool isSaving;

  RecoveryStepModel get currentStep => journey.steps[currentIndex];
  double get completionPercent => completedSteps.length / journey.steps.length;
  int get totalXp => completedSteps.fold<int>(0, (sum, id) {
    final RecoveryStepModel step = journey.steps.firstWhere((s) => s.id == id);
    return sum + step.rewardXp;
  });

  PathStepState copyWith({
    int? currentIndex,
    Map<String, String>? reflections,
    Set<String>? completedSteps,
    Set<String>? savedSteps,
    Map<String, int>? taskProgress,
    bool? isCompleting,
    bool? isSaving,
  }) => PathStepState(
    journey: journey,
    currentIndex: currentIndex ?? this.currentIndex,
    reflections: reflections ?? this.reflections,
    completedSteps: completedSteps ?? this.completedSteps,
    savedSteps: savedSteps ?? this.savedSteps,
    taskProgress: taskProgress ?? this.taskProgress,
    isCompleting: isCompleting ?? this.isCompleting,
    isSaving: isSaving ?? this.isSaving,
  );
}

class PathStepNotifier extends StateNotifier<PathStepState> {
  PathStepNotifier()
    : super(
        const PathStepState(
          journey: PathStepMockData.journey,
          currentIndex: 0,
          reflections: <String, String>{},
          completedSteps: <String>{},
          savedSteps: <String>{},
          taskProgress: <String, int>{},
          isCompleting: false,
          isSaving: false,
        ),
      );

  void goToStep(int index) {
    if (index < 0 || index >= state.journey.steps.length) {
      return;
    }
    state = state.copyWith(currentIndex: index);
  }

  void updateReflection(String stepId, String value, int max) {
    if (value.length > max) {
      return;
    }
    final Map<String, String> map = Map<String, String>.from(state.reflections)
      ..[stepId] = value;
    state = state.copyWith(reflections: map);
  }

  void incrementTask(String taskId, int target) {
    final Map<String, int> map = Map<String, int>.from(state.taskProgress);
    final int next = (map[taskId] ?? 0) + 1;
    map[taskId] = next > target ? target : next;
    state = state.copyWith(taskProgress: map);
  }

  void decrementTask(String taskId) {
    final Map<String, int> map = Map<String, int>.from(state.taskProgress);
    final int next = (map[taskId] ?? 0) - 1;
    map[taskId] = next < 0 ? 0 : next;
    state = state.copyWith(taskProgress: map);
  }

  Future<void> completeCurrentStep() async {
    state = state.copyWith(isCompleting: true);
    await Future<void>.delayed(const Duration(milliseconds: 420));
    final String id = state.currentStep.id;
    final Set<String> completed = Set<String>.from(state.completedSteps)
      ..add(id);
    state = state.copyWith(isCompleting: false, completedSteps: completed);
  }

  Future<void> saveCurrentStep() async {
    state = state.copyWith(isSaving: true);
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final String id = state.currentStep.id;
    final Set<String> saved = Set<String>.from(state.savedSteps);
    if (saved.contains(id)) {
      saved.remove(id);
    } else {
      saved.add(id);
    }
    state = state.copyWith(isSaving: false, savedSteps: saved);
  }
}

final pathStepProvider = StateNotifierProvider<PathStepNotifier, PathStepState>(
  (ref) => PathStepNotifier(),
);
