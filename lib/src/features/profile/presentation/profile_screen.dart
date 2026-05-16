import 'package:awwab/src/features/profile/state/profile_state.dart';
import 'package:awwab/src/features/profile/widgets/achievement_badge_tile.dart';
import 'package:awwab/src/features/profile/widgets/profile_aura_card.dart';
import 'package:awwab/src/features/profile/widgets/profile_bottom_nav.dart';
import 'package:awwab/src/features/profile/widgets/profile_header_card.dart';
import 'package:awwab/src/features/profile/widgets/profile_preference_tile.dart';
import 'package:awwab/src/features/profile/widgets/profile_section_shell.dart';
import 'package:awwab/src/features/profile/widgets/profile_summary_stat_tile.dart';
import 'package:awwab/src/features/profile/widgets/profile_top_bar.dart';
import 'package:awwab/src/theme/app_motion.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:awwab/src/widgets/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider);
    final model = state.model;
    final size = MediaQuery.sizeOf(context);
    final bool compact = size.height < 800 || size.width < 390;

    return Scaffold(
      body: SafeArea(
        child: ResponsiveContainer(
          maxWidth: 1050,
          child: ListView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              compact ? AppSpacing.sm : AppSpacing.md,
              compact ? AppSpacing.sm : AppSpacing.md,
              compact ? AppSpacing.sm : AppSpacing.md,
              compact ? AppSpacing.sm : AppSpacing.md,
            ),
            children: <Widget>[
              ProfileTopBar(
                    title: model.title,
                    subtitle: model.subtitle,
                    compact: compact,
                  )
                  .animate()
                  .fadeIn(duration: AppMotion.normalMs.ms)
                  .slideY(begin: 0.03),
              SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
              ProfileHeaderCard(model: model, compact: compact)
                  .animate()
                  .fadeIn(delay: 70.ms, duration: AppMotion.normalMs.ms)
                  .slideY(begin: 0.03),
              SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
              ProfileAuraCard(model: model, compact: compact).animate().fadeIn(
                delay: 120.ms,
                duration: AppMotion.normalMs.ms,
              ),
              SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
              ProfileSectionShell(
                title: 'ACHIEVEMENTS',
                trailing: 'View All',
                compact: compact,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final int count = constraints.maxWidth < 540 ? 3 : 5;
                    return GridView.builder(
                      itemCount: model.achievements.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: count,
                        crossAxisSpacing: AppSpacing.sm,
                        mainAxisSpacing: AppSpacing.sm,
                        childAspectRatio: count == 3 ? 0.93 : 0.78,
                      ),
                      itemBuilder: (context, index) =>
                          AchievementBadgeTile(
                                item: model.achievements[index],
                                compact: compact || count == 3,
                              )
                              .animate()
                              .fadeIn(
                                delay: (160 + (index * 35)).ms,
                                duration: AppMotion.fastMs.ms,
                              )
                              .slideY(begin: 0.08),
                    );
                  },
                ),
              ),
              SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
              ProfileSectionShell(
                title: 'RECOVERY SUMMARY',
                trailing: 'View Details',
                compact: compact,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final bool stacked = constraints.maxWidth < 640;
                    if (stacked) {
                      return Column(
                        children: model.recoverySummary
                            .asMap()
                            .entries
                            .map(
                              (entry) => Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      entry.key ==
                                          model.recoverySummary.length - 1
                                      ? 0
                                      : AppSpacing.sm,
                                ),
                                child: ProfileSummaryStatTile(
                                  stat: entry.value,
                                  compact: true,
                                ),
                              ),
                            )
                            .toList(),
                      );
                    }
                    return Row(
                      children: model.recoverySummary
                          .asMap()
                          .entries
                          .map(
                            (entry) => Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.xs,
                                ),
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
                                child: ProfileSummaryStatTile(
                                  stat: entry.value,
                                  compact: compact,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ).animate().fadeIn(
                delay: 280.ms,
                duration: AppMotion.normalMs.ms,
              ),
              SizedBox(height: compact ? AppSpacing.sm : AppSpacing.md),
              ProfileSectionShell(
                title: 'PREFERENCES',
                compact: compact,
                child: Column(
                  children: model.preferences
                      .asMap()
                      .entries
                      .map(
                        (entry) => ProfilePreferenceTile(
                          item: entry.value,
                          compact: compact,
                          isLast: entry.key == model.preferences.length - 1,
                        ),
                      )
                      .toList(),
                ),
              ).animate().fadeIn(
                delay: 330.ms,
                duration: AppMotion.normalMs.ms,
              ),
              SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
              const ProfileBottomNav().animate().fadeIn(
                delay: 370.ms,
                duration: AppMotion.normalMs.ms,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
