import 'package:flutter/material.dart';

enum RecoveryPathStatus { active, inactive, completed }

class RecoveryPathsScreenModel {
  const RecoveryPathsScreenModel({
    required this.title,
    required this.subtitle,
    required this.heroTitle,
    required this.heroSubtitle,
    required this.recommendedTitle,
    required this.allPathsTitle,
    required this.bottomTitle,
    required this.bottomSubtitle,
    required this.recommendedPath,
    required this.paths,
  });

  final String title;
  final String subtitle;
  final String heroTitle;
  final String heroSubtitle;
  final String recommendedTitle;
  final String allPathsTitle;
  final String bottomTitle;
  final String bottomSubtitle;
  final RecoveryPathModel recommendedPath;
  final List<RecoveryPathModel> paths;
}

class RecoveryPathModel {
  const RecoveryPathModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.steps,
    required this.estimatedMinutes,
    required this.progress,
    required this.stepNumber,
    required this.status,
    required this.accent,
    required this.softBackground,
    required this.icon,
  });

  final String id;
  final String title;
  final String subtitle;
  final int steps;
  final int estimatedMinutes;
  final double progress;
  final int stepNumber;
  final RecoveryPathStatus status;
  final Color accent;
  final Color softBackground;
  final IconData icon;
}
