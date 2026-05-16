import 'package:flutter/material.dart';

class ProgressAnalyticsModel {
  const ProgressAnalyticsModel({
    required this.title,
    required this.subtitle,
    required this.auraLevel,
    required this.auraStatus,
    required this.xpCurrent,
    required this.xpTarget,
    required this.xpToNext,
    required this.overview,
    required this.dailyProgress,
    required this.growthAreas,
    required this.milestones,
  });

  final String title;
  final String subtitle;
  final int auraLevel;
  final String auraStatus;
  final int xpCurrent;
  final int xpTarget;
  final int xpToNext;
  final List<OverviewStatModel> overview;
  final List<DailyProgressPoint> dailyProgress;
  final List<GrowthAreaModel> growthAreas;
  final List<MilestoneModel> milestones;

  double get auraProgress => xpCurrent / xpTarget;
}

class OverviewStatModel {
  const OverviewStatModel({
    required this.title,
    required this.value,
    required this.delta,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
  });

  final String title;
  final String value;
  final String delta;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
}

class DailyProgressPoint {
  const DailyProgressPoint({required this.day, required this.value});

  final String day;
  final double value;
}

class GrowthAreaModel {
  const GrowthAreaModel({
    required this.name,
    required this.percent,
    required this.color,
    required this.icon,
  });

  final String name;
  final int percent;
  final Color color;
  final IconData icon;
}

class MilestoneModel {
  const MilestoneModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
}
