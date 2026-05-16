import 'package:flutter/material.dart';

class LogActionScreenModel {
  const LogActionScreenModel({
    required this.title,
    required this.subtitle,
    required this.bannerTitle,
    required this.bannerSubtitle,
    required this.sectionTitle,
    required this.sectionSubtitle,
    required this.inputTitle,
    required this.inputSubtitle,
    required this.inputHint,
    required this.buttonLabel,
    required this.securityNote,
    required this.maxCharacters,
    required this.categories,
  });

  final String title;
  final String subtitle;
  final String bannerTitle;
  final String bannerSubtitle;
  final String sectionTitle;
  final String sectionSubtitle;
  final String inputTitle;
  final String inputSubtitle;
  final String inputHint;
  final String buttonLabel;
  final String securityNote;
  final int maxCharacters;
  final List<LogActionCategoryModel> categories;
}

class LogActionCategoryModel {
  const LogActionCategoryModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.softBackground,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final Color softBackground;
}
