import 'package:flutter/material.dart';

class HomeDashboardModel {
  const HomeDashboardModel({
    required this.auraLevel,
    required this.rankLabel,
    required this.systemStatus,
    required this.statusDescription,
    required this.xpCurrent,
    required this.xpTarget,
    required this.nextLevel,
    required this.metrics,
    required this.quest,
    required this.quickActions,
    required this.quote,
  });

  final int auraLevel;
  final String rankLabel;
  final String systemStatus;
  final String statusDescription;
  final int xpCurrent;
  final int xpTarget;
  final int nextLevel;
  final List<StatusMetricModel> metrics;
  final QuestModel quest;
  final List<QuickActionModel> quickActions;
  final String quote;

  double get xpProgress => xpCurrent / xpTarget;
}

class StatusMetricModel {
  const StatusMetricModel({
    required this.title,
    required this.value,
    required this.unit,
    required this.color,
    required this.icon,
  });

  final String title;
  final int value;
  final String unit;
  final Color color;
  final IconData icon;

  double get progress => value / 100;
}

class QuestModel {
  const QuestModel({
    required this.title,
    required this.description,
    required this.rewardXp,
  });

  final String title;
  final String description;
  final int rewardXp;
}

class QuickActionModel {
  const QuickActionModel({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.background,
  });

  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final Color background;
}
