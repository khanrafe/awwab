import 'package:awwab/src/features/progress_analytics/models/progress_analytics_model.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class MilestonesCard extends StatelessWidget {
  const MilestonesCard({super.key, required this.items, this.compact = false});

  final List<MilestoneModel> items;
  final bool compact;

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
        padding: EdgeInsets.all(compact ? AppSpacing.sm : AppSpacing.md),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'RECENT MILESTONES',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: compact ? 17 : 20.8,
                    color: const Color(0xFF141D4B),
                  ),
                ),
                const Spacer(),
                Text(
                  'View All',
                  style: textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF745CFF),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: Color(0xFF745CFF),
                ),
              ],
            ),
            SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
            LayoutBuilder(
              builder: (context, constraints) {
                final bool horizontal = constraints.maxWidth >= 760;
                if (horizontal) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: items
                        .asMap()
                        .entries
                        .map(
                          (entry) => Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: entry.key == items.length - 1
                                    ? 0
                                    : AppSpacing.sm,
                              ),
                              child: _MilestoneItem(
                                item: entry.value,
                                compact: compact,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                }

                return Column(
                  children: items
                      .map(
                        (item) => Padding(
                          padding: EdgeInsets.only(
                            bottom: item == items.last ? 0 : AppSpacing.sm,
                          ),
                          child: _MilestoneItem(item: item, compact: true),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MilestoneItem extends StatelessWidget {
  const _MilestoneItem({required this.item, required this.compact});

  final MilestoneModel item;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          radius: compact ? 18 : 22,
          backgroundColor: item.iconBg,
          child: Icon(
            item.icon,
            color: item.iconColor,
            size: compact ? 20 : 24,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                item.title,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: compact ? 14.8 : 15.6,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1A2250),
                ),
              ),
              SizedBox(height: compact ? 2 : AppSpacing.xxs),
              Text(
                item.subtitle,
                style: textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF687295),
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                  fontSize: compact ? 13 : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
