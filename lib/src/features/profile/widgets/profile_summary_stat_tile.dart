import 'package:awwab/src/features/profile/models/profile_model.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class ProfileSummaryStatTile extends StatelessWidget {
  const ProfileSummaryStatTile({
    super.key,
    required this.stat,
    required this.compact,
  });

  final ProfileSummaryStat stat;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: compact ? 16 : 18,
          backgroundColor: stat.iconBg,
          child: Icon(
            stat.icon,
            color: stat.iconColor,
            size: compact ? 17 : 19,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                stat.value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleLarge?.copyWith(
                  color: const Color(0xFF121B49),
                  fontWeight: FontWeight.w800,
                  fontSize: compact ? 18 : 22,
                ),
              ),
              Text(
                stat.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF6B7392),
                  fontWeight: FontWeight.w600,
                  fontSize: compact ? 12 : 13.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
