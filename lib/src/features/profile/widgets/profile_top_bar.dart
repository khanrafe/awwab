import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class ProfileTopBar extends StatelessWidget {
  const ProfileTopBar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.compact,
  });

  final String title;
  final String subtitle;
  final bool compact;

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
                  fontSize: compact ? 34 : 40,
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
                  fontSize: compact ? 15 : 16,
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
          child: SizedBox(
            width: compact ? 50 : 56,
            height: compact ? 50 : 56,
            child: const Icon(
              Icons.settings_outlined,
              color: Color(0xFF735BFF),
              size: 28,
            ),
          ),
        ),
      ],
    );
  }
}
