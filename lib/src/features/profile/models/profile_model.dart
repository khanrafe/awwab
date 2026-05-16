import 'package:flutter/material.dart';

class ProfileModel {
  const ProfileModel({
    required this.title,
    required this.subtitle,
    required this.name,
    required this.level,
    required this.levelTitle,
    required this.quote,
    required this.streak,
    required this.purity,
    required this.energy,
    required this.totalXp,
    required this.auraProgress,
    required this.currentXp,
    required this.targetXp,
    required this.recoverySummary,
    required this.achievements,
    required this.preferences,
  });

  final String title;
  final String subtitle;
  final String name;
  final int level;
  final String levelTitle;
  final String quote;
  final int streak;
  final int purity;
  final int energy;
  final int totalXp;
  final double auraProgress;
  final int currentXp;
  final int targetXp;
  final List<ProfileSummaryStat> recoverySummary;
  final List<AchievementModel> achievements;
  final List<PreferenceItem> preferences;
}

class ProfileHeaderStat {
  const ProfileHeaderStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
}

class ProfileSummaryStat {
  const ProfileSummaryStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
}

class AchievementModel {
  const AchievementModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.bg,
    required this.unlocked,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color bg;
  final bool unlocked;
}

class PreferenceItem {
  const PreferenceItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
}
