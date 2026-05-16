import 'package:awwab/src/features/recovery_paths/data/recovery_paths_mock_data.dart';
import 'package:awwab/src/features/recovery_paths/models/recovery_paths_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecoveryPathsState {
  const RecoveryPathsState({required this.model, required this.selectedPathId});

  final RecoveryPathsScreenModel model;
  final String selectedPathId;

  RecoveryPathModel get selectedPath =>
      model.paths.firstWhere((path) => path.id == selectedPathId);

  RecoveryPathsState copyWith({String? selectedPathId}) => RecoveryPathsState(
    model: model,
    selectedPathId: selectedPathId ?? this.selectedPathId,
  );
}

class RecoveryPathsNotifier extends StateNotifier<RecoveryPathsState> {
  RecoveryPathsNotifier()
    : super(
        RecoveryPathsState(
          model: RecoveryPathsMockData.model,
          selectedPathId: RecoveryPathsMockData.model.recommendedPath.id,
        ),
      );

  void selectPath(String id) {
    state = state.copyWith(selectedPathId: id);
  }
}

final recoveryPathsProvider =
    StateNotifierProvider<RecoveryPathsNotifier, RecoveryPathsState>(
      (ref) => RecoveryPathsNotifier(),
    );
