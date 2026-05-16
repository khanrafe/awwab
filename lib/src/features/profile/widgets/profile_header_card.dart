import 'package:awwab/src/features/profile/models/profile_model.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({
    super.key,
    required this.model,
    required this.compact,
  });

  final ProfileModel model;
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
            LayoutBuilder(
              builder: (context, constraints) {
                final bool vertical = constraints.maxWidth < 650;
                if (vertical) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const _ProfileAvatar(),
                      const SizedBox(height: AppSpacing.sm),
                      _ProfileIdentity(model: model, compact: true),
                    ],
                  );
                }

                return Row(
                  children: <Widget>[
                    const _ProfileAvatar(),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: _ProfileIdentity(model: model, compact: compact),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: compact ? AppSpacing.xs : AppSpacing.sm),
            Divider(color: const Color(0xFFEAEDF7), height: compact ? 14 : 20),
            SizedBox(height: compact ? 6 : AppSpacing.xs),
            _ProfileStatsRow(
              model: model,
              textTheme: textTheme,
              compact: compact,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: 1.28,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              const Color(0xFFF4F1FF),
              const Color(0xFFE9E4FF).withValues(alpha: 0.95),
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFA38CFF), width: 8),
              ),
            ),
            const Icon(
              Icons.person_rounded,
              size: 148,
              color: Color(0xFF161E6E),
            ),
            const Positioned(
              right: 10,
              bottom: 10,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.edit_rounded,
                  color: Color(0xFF7A5DFF),
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _ProfileIdentity extends StatelessWidget {
  const _ProfileIdentity({required this.model, required this.compact});

  final ProfileModel model;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Text(
                model.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF131C4E),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            const Icon(Icons.edit_rounded, color: Color(0xFF8D77FF), size: 16),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.xs,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFF1ECFF),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Text(
                'Lv. ${model.level}',
                style: textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF6F58FB),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Text(
              model.levelTitle,
              style: textTheme.titleMedium?.copyWith(
                color: const Color(0xFF795FFF),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        SizedBox(height: compact ? AppSpacing.xs : AppSpacing.sm),
        Text(
          model.quote,
          style: textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF5D6587),
            fontWeight: FontWeight.w600,
            height: 1.35,
            fontSize: compact ? 18 : 20,
          ),
        ),
      ],
    );
  }
}

class _ProfileStatsRow extends StatelessWidget {
  const _ProfileStatsRow({
    required this.model,
    required this.textTheme,
    required this.compact,
  });

  final ProfileModel model;
  final TextTheme textTheme;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final List<ProfileSummaryStat> stats = <ProfileSummaryStat>[
      ProfileSummaryStat(
        label: 'Day Streak',
        value: model.streak.toString(),
        icon: Icons.local_fire_department_rounded,
        iconColor: const Color(0xFF745CFF),
        iconBg: const Color(0xFFECE8FF),
      ),
      ProfileSummaryStat(
        label: 'Purity',
        value: '${model.purity}%',
        icon: Icons.check_circle_rounded,
        iconColor: const Color(0xFF39C879),
        iconBg: const Color(0xFFE8FBF1),
      ),
      ProfileSummaryStat(
        label: 'Energy',
        value: '${model.energy}%',
        icon: Icons.flash_on_rounded,
        iconColor: const Color(0xFFF4B42B),
        iconBg: const Color(0xFFFFF6E3),
      ),
      const ProfileSummaryStat(
        label: 'Total XP',
        value: '1,280',
        icon: Icons.auto_awesome_rounded,
        iconColor: Color(0xFF6E58FF),
        iconBg: Color(0xFFEFEAFF),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool wrap = constraints.maxWidth < 680;
        if (!wrap) {
          return Row(
            children: stats
                .asMap()
                .entries
                .map(
                  (entry) => Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: compact ? 6 : 8),
                      decoration: BoxDecoration(
                        border: entry.key == 0
                            ? null
                            : const Border(
                                left: BorderSide(
                                  color: Color(0xFFEAEFF8),
                                  width: 1,
                                ),
                              ),
                      ),
                      child: _HeaderStat(
                        stat: entry.value,
                        textTheme: textTheme,
                        compact: compact,
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        }

        return GridView.builder(
          itemCount: stats.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 2.5,
          ),
          itemBuilder: (context, index) => _HeaderStat(
            stat: stats[index],
            textTheme: textTheme,
            compact: true,
          ),
        );
      },
    );
  }
}

class _HeaderStat extends StatelessWidget {
  const _HeaderStat({
    required this.stat,
    required this.textTheme,
    required this.compact,
  });

  final ProfileSummaryStat stat;
  final TextTheme textTheme;
  final bool compact;

  @override
  Widget build(BuildContext context) => Row(
    children: <Widget>[
      CircleAvatar(
        radius: compact ? 15 : 17,
        backgroundColor: stat.iconBg,
        child: Icon(stat.icon, color: stat.iconColor, size: compact ? 16 : 18),
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
                fontSize: compact ? 12.5 : 13.5,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
