import 'package:awwab/src/features/home/models/home_dashboard_model.dart';
import 'package:awwab/src/features/home/widgets/home_ui_tokens.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class QuestCard extends StatelessWidget {
  const QuestCard({super.key, required this.quest});

  final QuestModel quest;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: AppShadows.soft,
      ),
      child: Padding(
        padding: const EdgeInsets.all(HomeUiTokens.cardPadding),
        child: Row(
          children: <Widget>[
            const CircleAvatar(
              radius: 22,
              backgroundColor: Color(0xFFF4F0FF),
              child: Icon(Icons.auto_awesome, color: Color(0xFF8A63FF)),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'TODAY\'S QUEST',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF7858EB),
                      fontSize: 13,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    quest.title,
                    style: textTheme.titleMedium?.copyWith(
                      fontSize: 33 * 0.55,
                      fontWeight: FontWeight.w800,
                      color: HomeUiTokens.titleColor,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    quest.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium?.copyWith(
                      height: 1.35,
                      fontWeight: FontWeight.w500,
                      color: HomeUiTokens.subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F3FF),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        Icons.hexagon,
                        size: 14,
                        color: Color(0xFF7A5DFF),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '+${quest.rewardXp} XP',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF3A3D78),
                          fontSize: 28 * 0.55,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                const CircleAvatar(
                  radius: 19,
                  backgroundColor: Color(0xFFF6F7FB),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: Color(0xFF2C3B73),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
