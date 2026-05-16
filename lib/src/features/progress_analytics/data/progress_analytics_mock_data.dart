import 'package:awwab/src/features/progress_analytics/models/progress_analytics_model.dart';
import 'package:flutter/material.dart';

abstract final class ProgressAnalyticsMockData {
  static const model = ProgressAnalyticsModel(
    title: 'Progress',
    subtitle: 'Track your growth. See how far you\'ve come.',
    auraLevel: 12,
    auraStatus: 'Rising',
    xpCurrent: 1280,
    xpTarget: 2000,
    xpToNext: 720,
    overview: <OverviewStatModel>[
      OverviewStatModel(
        title: 'Actions Logged',
        value: '28',
        delta: '↑ 12% vs last week',
        icon: Icons.trending_up_rounded,
        iconBg: Color(0xFFF1ECFF),
        iconColor: Color(0xFF7E62FF),
      ),
      OverviewStatModel(
        title: 'Steps Completed',
        value: '16',
        delta: '↑ 18% vs last week',
        icon: Icons.check_circle_rounded,
        iconBg: Color(0xFFE9F8EE),
        iconColor: Color(0xFF40B66F),
      ),
      OverviewStatModel(
        title: 'Day Streak',
        value: '7',
        delta: '↑ 1 day',
        icon: Icons.local_fire_department_rounded,
        iconBg: Color(0xFFFFF4E7),
        iconColor: Color(0xFFFFA334),
      ),
      OverviewStatModel(
        title: 'XP Earned',
        value: '1,840',
        delta: '↑ 22% vs last week',
        icon: Icons.auto_awesome_rounded,
        iconBg: Color(0xFFEDF4FF),
        iconColor: Color(0xFF4D8DFF),
      ),
    ],
    dailyProgress: <DailyProgressPoint>[
      DailyProgressPoint(day: 'Mon', value: 15),
      DailyProgressPoint(day: 'Tue', value: 33),
      DailyProgressPoint(day: 'Wed', value: 47),
      DailyProgressPoint(day: 'Thu', value: 58),
      DailyProgressPoint(day: 'Fri', value: 82),
      DailyProgressPoint(day: 'Sat', value: 70),
      DailyProgressPoint(day: 'Sun', value: 90),
    ],
    growthAreas: <GrowthAreaModel>[
      GrowthAreaModel(
        name: 'Self-Control',
        percent: 78,
        color: Color(0xFF7A5DFF),
        icon: Icons.psychology_rounded,
      ),
      GrowthAreaModel(
        name: 'Emotional Awareness',
        percent: 62,
        color: Color(0xFFFF87A8),
        icon: Icons.favorite_rounded,
      ),
      GrowthAreaModel(
        name: 'Relationships',
        percent: 55,
        color: Color(0xFFFFB03A),
        icon: Icons.diversity_3_rounded,
      ),
      GrowthAreaModel(
        name: 'Discipline',
        percent: 70,
        color: Color(0xFF4D8DFF),
        icon: Icons.shield_rounded,
      ),
      GrowthAreaModel(
        name: 'Self-Care',
        percent: 65,
        color: Color(0xFF44C774),
        icon: Icons.spa_rounded,
      ),
    ],
    milestones: <MilestoneModel>[
      MilestoneModel(
        title: '7 Day Streak',
        subtitle: 'You stayed consistent for 7 days!',
        icon: Icons.workspace_premium_rounded,
        iconBg: Color(0xFFF2ECFF),
        iconColor: Color(0xFF7A5DFF),
      ),
      MilestoneModel(
        title: '10 Steps Completed',
        subtitle: 'You\'ve completed 10 recovery steps!',
        icon: Icons.gps_fixed_rounded,
        iconBg: Color(0xFFE8FAEF),
        iconColor: Color(0xFF3FB96E),
      ),
      MilestoneModel(
        title: 'First Week',
        subtitle: 'One week of real progress!',
        icon: Icons.local_fire_department_rounded,
        iconBg: Color(0xFFFFF3E5),
        iconColor: Color(0xFFFFA531),
      ),
    ],
  );
}
