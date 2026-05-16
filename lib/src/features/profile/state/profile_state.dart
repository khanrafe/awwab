import 'package:awwab/src/features/profile/data/profile_mock_data.dart';
import 'package:awwab/src/features/profile/models/profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileState {
  const ProfileState({required this.model});

  final ProfileModel model;
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier() : super(const ProfileState(model: kProfileModel));
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>(
  (ref) => ProfileNotifier(),
);
