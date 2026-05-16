import 'package:awwab/src/features/home/widgets/home_bottom_nav.dart';
import 'package:awwab/src/features/recovery_paths/state/recovery_paths_state.dart';
import 'package:awwab/src/features/recovery_paths/widgets/recommended_recovery_path_card.dart';
import 'package:awwab/src/features/recovery_paths/widgets/recovery_path_list_card.dart';
import 'package:awwab/src/features/recovery_paths/widgets/recovery_paths_hero_card.dart';
import 'package:awwab/src/features/recovery_paths/widgets/recovery_paths_motivation_card.dart';
import 'package:awwab/src/features/recovery_paths/widgets/recovery_paths_top_bar.dart';
import 'package:awwab/src/routes/app_router.dart';
import 'package:awwab/src/theme/app_motion.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:awwab/src/widgets/app_bottom_nav.dart';
import 'package:awwab/src/widgets/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RecoveryPathsScreen extends ConsumerWidget {
  const RecoveryPathsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recoveryPathsProvider);
    final notifier = ref.read(recoveryPathsProvider.notifier);
    final model = state.model;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.sizeOf(context);
    final bool compact = size.height < 800 || size.width < 390;

    return Scaffold(
      body: SafeArea(
        child: ResponsiveContainer(
          maxWidth: 980,
          child: ListView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              compact ? AppSpacing.sm : AppSpacing.md,
              compact ? AppSpacing.sm : AppSpacing.md,
              compact ? AppSpacing.sm : AppSpacing.md,
              compact ? AppSpacing.sm : AppSpacing.md,
            ),
            children: <Widget>[
              RecoveryPathsTopBar(
                    title: model.title,
                    subtitle: model.subtitle,
                    onBack: context.pop,
                  )
                  .animate()
                  .fadeIn(duration: AppMotion.normalMs.ms)
                  .slideY(begin: 0.04),
              SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
              RecoveryPathsHeroCard(
                    title: model.heroTitle,
                    subtitle: model.heroSubtitle,
                  )
                  .animate()
                  .fadeIn(delay: 70.ms, duration: AppMotion.slowMs.ms)
                  .slideY(begin: 0.05),
              SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
              Text(
                model.recommendedTitle,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 18.5,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF131C4A),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              RecommendedRecoveryPathCard(
                path: model.recommendedPath,
                onTap: () {
                  notifier.selectPath(model.recommendedPath.id);
                  context.pushNamed(AppRouteNames.pathStep);
                },
              ).animate().fadeIn(
                delay: 140.ms,
                duration: AppMotion.normalMs.ms,
              ),
              SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
              Text(
                model.allPathsTitle,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 18.5,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF131C4A),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              ...model.paths.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child:
                      RecoveryPathListCard(
                            path: entry.value,
                            selected: state.selectedPathId == entry.value.id,
                            onTap: () => notifier.selectPath(entry.value.id),
                          )
                          .animate()
                          .fadeIn(
                            delay: (190 + (entry.key * 60)).ms,
                            duration: AppMotion.normalMs.ms,
                          )
                          .slideY(begin: 0.02),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              RecoveryPathsMotivationCard(
                title: model.bottomTitle,
                subtitle: model.bottomSubtitle,
              ).animate().fadeIn(
                delay: 350.ms,
                duration: AppMotion.normalMs.ms,
              ),
              SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
              const HomeBottomNav(activeTab: AppNavTab.tasks).animate().fadeIn(
                delay: 420.ms,
                duration: AppMotion.normalMs.ms,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
