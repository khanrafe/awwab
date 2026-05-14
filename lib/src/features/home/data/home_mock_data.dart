import 'package:awwab/src/features/home/models/home_dashboard_model.dart';
import 'package:flutter/material.dart';

abstract final class HomeMockData {
  static const dashboard = HomeDashboardModel(
    auraLevel: 18,
    rankLabel: 'Rank B',
    systemStatus: 'RECOVERING',
    statusDescription: 'You are healing. Keep going, one step at a time.',
    xpCurrent: 2450,
    xpTarget: 3000,
    nextLevel: 19,
    metrics: <StatusMetricModel>[
      StatusMetricModel(
        title: 'ENERGY',
        value: 72,
        unit: '%',
        color: Color(0xFF58A6FF),
        icon: Icons.bolt_rounded,
      ),
      StatusMetricModel(
        title: 'PURITY',
        value: 65,
        unit: '%',
        color: Color(0xFF72D97E),
        icon: Icons.favorite_rounded,
      ),
      StatusMetricModel(
        title: 'DAY STREAK',
        value: 14,
        unit: 'Days',
        color: Color(0xFFFFA24C),
        icon: Icons.local_fire_department_rounded,
      ),
    ],
    quest: QuestModel(
      title: 'Complete Reflection Task',
      description: 'Take time to reflect and write honestly about your day.',
      rewardXp: 50,
    ),
    quickActions: <QuickActionModel>[
      QuickActionModel(
        title: 'Log Action',
        subtitle: 'Record & Reflect',
        color: Color(0xFF8A63FF),
        icon: Icons.edit_square,
        background: Color(0xFFF7F3FF),
      ),
      QuickActionModel(
        title: 'Recovery Paths',
        subtitle: 'Continue Your Journey',
        color: Color(0xFF5E8CFF),
        icon: Icons.alt_route,
        background: Color(0xFFF2F6FF),
      ),
      QuickActionModel(
        title: 'Progress',
        subtitle: 'Track Your Growth',
        color: Color(0xFF3DBA75),
        icon: Icons.bar_chart_rounded,
        background: Color(0xFFEEFBF2),
      ),
    ],
    quote: 'Every small step forward is still progress.',
  );
}
