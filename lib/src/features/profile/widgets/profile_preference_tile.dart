import 'package:awwab/src/features/profile/models/profile_model.dart';
import 'package:awwab/src/theme/app_motion.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class ProfilePreferenceTile extends StatelessWidget {
  const ProfilePreferenceTile({
    super.key,
    required this.item,
    required this.compact,
    required this.isLast,
  });

  final PreferenceItem item;
  final bool compact;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.sm),
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: AppMotion.fastMs),
        padding: EdgeInsets.symmetric(vertical: compact ? 8 : 10),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : const Border(
                  bottom: BorderSide(color: Color(0xFFE9EDF7), width: 1),
                ),
        ),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: compact ? 16 : 18,
              backgroundColor: const Color(0xFFF4F6FC),
              child: Icon(
                item.icon,
                color: const Color(0xFF7A82A1),
                size: compact ? 17 : 19,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Wrap(
                spacing: AppSpacing.xs,
                runSpacing: 2,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Text(
                    item.title,
                    style: textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF1A2350),
                      fontWeight: FontWeight.w700,
                      fontSize: compact ? 16 : 18,
                    ),
                  ),
                  Text(
                    item.subtitle,
                    style: textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF727C9D),
                      fontWeight: FontWeight.w600,
                      fontSize: compact ? 12 : 13.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: Color(0xFF98A0BD),
            ),
          ],
        ),
      ),
    );
  }
}
