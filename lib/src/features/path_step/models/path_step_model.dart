import 'package:flutter/material.dart';

enum RecoveryTaskType { tasbihCounter, breathing, gratitude, mindfulness }

class RecoveryJourneyModel {
  const RecoveryJourneyModel({
    required this.screenTitle,
    required this.screenSubtitle,
    required this.pathName,
    required this.pathAccent,
    required this.totalSteps,
    required this.steps,
  });

  final String screenTitle;
  final String screenSubtitle;
  final String pathName;
  final Color pathAccent;
  final int totalSteps;
  final List<RecoveryStepModel> steps;
}

class RecoveryStepModel {
  const RecoveryStepModel({
    required this.id,
    required this.title,
    required this.description,
    required this.guidedTitle,
    required this.guidedBullets,
    required this.task,
    required this.estimatedMinutes,
    required this.rewardXp,
    required this.reflectTitle,
    required this.reflectSubtitle,
    required this.reflectHint,
    required this.reflectMax,
    required this.completeLabel,
    required this.saveLabel,
  });

  final String id;
  final String title;
  final String description;
  final String guidedTitle;
  final List<String> guidedBullets;
  final SpiritualTaskModel? task;
  final int estimatedMinutes;
  final int rewardXp;
  final String reflectTitle;
  final String reflectSubtitle;
  final String reflectHint;
  final int reflectMax;
  final String completeLabel;
  final String saveLabel;
}

class SpiritualTaskModel {
  const SpiritualTaskModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.target,
    this.prompt,
  });

  final String id;
  final String title;
  final String subtitle;
  final RecoveryTaskType type;
  final int target;
  final String? prompt;
}
