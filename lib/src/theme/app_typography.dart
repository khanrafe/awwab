import 'package:awwab/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTypography {
  static TextTheme textTheme() => GoogleFonts.manropeTextTheme().copyWith(
    headlineMedium: GoogleFonts.manrope(
      fontSize: 28,
      fontWeight: FontWeight.w800,
      height: 1.16,
      color: AppColors.textPrimary,
    ),
    headlineSmall: GoogleFonts.manrope(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      height: 1.2,
      color: AppColors.textPrimary,
    ),
    titleLarge: GoogleFonts.manrope(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      height: 1.2,
      color: AppColors.textPrimary,
    ),
    titleMedium: GoogleFonts.manrope(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      height: 1.22,
      color: AppColors.textPrimary,
    ),
    bodyLarge: GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.35,
      color: AppColors.textSecondary,
    ),
    bodyMedium: GoogleFonts.manrope(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      height: 1.35,
      color: AppColors.textSecondary,
    ),
    bodySmall: GoogleFonts.manrope(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      height: 1.35,
      color: AppColors.textSecondary,
    ),
    labelLarge: GoogleFonts.manrope(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      height: 1.2,
      color: AppColors.textPrimary,
    ),
  );
}
