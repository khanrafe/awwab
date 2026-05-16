import 'package:awwab/src/features/profile/models/profile_model.dart';
import 'package:awwab/src/theme/app_motion.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class AchievementBadgeTile extends StatelessWidget {
  const AchievementBadgeTile({
    super.key,
    required this.item,
    required this.compact,
  });

  final AchievementModel item;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Color iconColor = item.unlocked
        ? item.color
        : const Color(0xFFBFC5D9);

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: AppMotion.normalMs),
        opacity: item.unlocked ? 1 : 0.65,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: compact ? 2 : 4),
          child: Column(
            children: <Widget>[
              Container(
                width: compact ? 52 : 64,
                height: compact ? 52 : 64,
                decoration: BoxDecoration(
                  color: item.unlocked ? item.bg : const Color(0xFFF1F3F9),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(color: iconColor.withValues(alpha: 0.35)),
                ),
                child: Icon(
                  item.icon,
                  color: iconColor,
                  size: compact ? 28 : 32,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                item.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF1A2350),
                  fontWeight: FontWeight.w800,
                  fontSize: compact ? 11.5 : 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                item.subtitle,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF727C9D),
                  fontWeight: FontWeight.w600,
                  fontSize: compact ? 10.5 : 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
