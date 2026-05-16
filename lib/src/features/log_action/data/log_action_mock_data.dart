import 'package:awwab/src/features/log_action/models/log_action_model.dart';
import 'package:flutter/material.dart';

abstract final class LogActionMockData {
  static const model = LogActionScreenModel(
    title: 'Log Action',
    subtitle: 'Record what happened. Take the first step toward healing.',
    bannerTitle: 'You\'re taking action.',
    bannerSubtitle: 'Awareness is the beginning of real change.',
    sectionTitle: 'WHAT BEST DESCRIBES THIS?',
    sectionSubtitle: 'Choose the category that fits.',
    inputTitle: 'WHAT HAPPENED? (OPTIONAL)',
    inputSubtitle: 'Write freely. This is your space.',
    inputHint: 'Share as much or as little as you want...',
    buttonLabel: 'Begin Recovery Path',
    securityNote: 'Your logs are private and secure',
    maxCharacters: 500,
    categories: <LogActionCategoryModel>[
      LogActionCategoryModel(
        id: 'self_harm_habits',
        title: 'Self-Harm Habits',
        subtitle: 'Actions that harm myself',
        icon: Icons.heart_broken_rounded,
        accent: Color(0xFFFF6F6F),
        softBackground: Color(0xFFFFF1F3),
      ),
      LogActionCategoryModel(
        id: 'harm_to_others',
        title: 'Harm to Others',
        subtitle: 'Actions that may have harmed others',
        icon: Icons.group_remove_rounded,
        accent: Color(0xFFF7A93D),
        softBackground: Color(0xFFFFF6EA),
      ),
      LogActionCategoryModel(
        id: 'neglect',
        title: 'Neglect',
        subtitle: 'Actions of neglect or avoidance',
        icon: Icons.person_off_rounded,
        accent: Color(0xFF4BCD7D),
        softBackground: Color(0xFFEFFAF3),
      ),
    ],
  );
}
