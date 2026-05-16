import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class ProgressTopBar extends StatelessWidget {
  const ProgressTopBar({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: textTheme.headlineMedium?.copyWith(
                  fontSize: 28.5,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF121B49),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                style: textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF5F6788),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow: AppShadows.soft,
          ),
          child: const SizedBox(
            width: 56,
            height: 56,
            child: Icon(
              Icons.calendar_month_rounded,
              color: Color(0xFF735BFF),
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}
