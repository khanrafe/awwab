import 'package:awwab/src/theme/app_motion.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

abstract final class HomeUiTokens {
  static const sectionGap = AppSpacing.md;
  static const sectionGapLarge = AppSpacing.lg;
  static const cardPadding = AppSpacing.md;
  static const compactCardPadding = AppSpacing.sm;

  static const primaryCardRadius = AppRadius.lg;
  static const secondaryCardRadius = AppRadius.md;

  static const pageStaggerStepMs = 60;
  static const quickInteractionMs = AppMotion.fastMs;

  static const titleColor = Color(0xFF121A46);
  static const subtitleColor = Color(0xFF667093);
  static const accentViolet = Color(0xFF7A5DFF);
  static const softSurface = Color(0xFFF8F9FF);

  static double screenHorizontalPadding(double width) {
    if (width < 360) {
      return AppSpacing.sm;
    }
    if (width < 430) {
      return AppSpacing.md;
    }
    return AppSpacing.lg;
  }

  static double headingScale(double textScaleFactor) {
    if (textScaleFactor >= 1.2) {
      return 0.92;
    }
    return 1.0;
  }
}
