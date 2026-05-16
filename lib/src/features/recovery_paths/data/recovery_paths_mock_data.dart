import 'package:awwab/src/features/recovery_paths/models/recovery_paths_model.dart';
import 'package:flutter/material.dart';

abstract final class RecoveryPathsMockData {
  static const recommended = RecoveryPathModel(
    id: 'self_harm_habits',
    title: 'Self-Harm Habits',
    subtitle: 'Healing starts with understanding yourself.',
    steps: 8,
    estimatedMinutes: 10,
    progress: 0.38,
    stepNumber: 3,
    status: RecoveryPathStatus.active,
    accent: Color(0xFF7A5DFF),
    softBackground: Color(0xFFF3EEFF),
    icon: Icons.spa_rounded,
  );

  static const allPaths = <RecoveryPathModel>[
    RecoveryPathModel(
      id: 'self_harm_habits',
      title: 'Self-Harm Habits',
      subtitle: 'Build self-control and emotional safety.',
      steps: 8,
      estimatedMinutes: 10,
      progress: 0.38,
      stepNumber: 3,
      status: RecoveryPathStatus.active,
      accent: Color(0xFFFF8A8A),
      softBackground: Color(0xFFFFF2F2),
      icon: Icons.heart_broken_rounded,
    ),
    RecoveryPathModel(
      id: 'harm_to_others',
      title: 'Harm to Others',
      subtitle: 'Heal relationships and take responsibility.',
      steps: 7,
      estimatedMinutes: 8,
      progress: 0.0,
      stepNumber: 0,
      status: RecoveryPathStatus.inactive,
      accent: Color(0xFFFFC066),
      softBackground: Color(0xFFFFF6E8),
      icon: Icons.group_remove_rounded,
    ),
    RecoveryPathModel(
      id: 'neglect',
      title: 'Neglect',
      subtitle: 'Rebuild routines and take care of yourself.',
      steps: 6,
      estimatedMinutes: 7,
      progress: 0.0,
      stepNumber: 0,
      status: RecoveryPathStatus.inactive,
      accent: Color(0xFF72D98D),
      softBackground: Color(0xFFEFFAF3),
      icon: Icons.person_off_rounded,
    ),
  ];

  static const model = RecoveryPathsScreenModel(
    title: 'Recovery Paths',
    subtitle: 'Choose your path. Take one step at a time.',
    heroTitle: 'You\'re not alone.',
    heroSubtitle: 'Every step you take is a step toward healing.',
    recommendedTitle: 'RECOMMENDED FOR YOU',
    allPathsTitle: 'ALL RECOVERY PATHS',
    bottomTitle: 'Take it one step at a time.',
    bottomSubtitle: 'Small consistent actions create lasting change.',
    recommendedPath: recommended,
    paths: allPaths,
  );
}
