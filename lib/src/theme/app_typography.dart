import 'package:awwab/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTypography {
  static TextTheme textTheme() => GoogleFonts.manropeTextTheme().copyWith(
    headlineMedium: GoogleFonts.manrope(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      height: 1.12,
      color: AppColors.textPrimary,
    ),
    headlineSmall: GoogleFonts.manrope(
      fontSize: 21,
      fontWeight: FontWeight.w800,
      height: 1.14,
      color: AppColors.textPrimary,
    ),
    titleLarge: GoogleFonts.manrope(
      fontSize: 19,
      fontWeight: FontWeight.w700,
      height: 1.16,
      color: AppColors.textPrimary,
    ),
    titleMedium: GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      height: 1.16,
      color: AppColors.textPrimary,
    ),
    bodyLarge: GoogleFonts.manrope(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.28,
      color: AppColors.textSecondary,
    ),
    bodyMedium: GoogleFonts.manrope(
      fontSize: 13.5,
      fontWeight: FontWeight.w500,
      height: 1.26,
      color: AppColors.textSecondary,
    ),
    bodySmall: GoogleFonts.manrope(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.24,
      color: AppColors.textSecondary,
    ),
    labelLarge: GoogleFonts.manrope(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      height: 1.14,
      color: AppColors.textPrimary,
    ),
  );
}
