import 'package:awwab/src/features/home/widgets/home_bottom_nav.dart';
import 'package:awwab/src/features/path_step/state/path_step_state.dart';
import 'package:awwab/src/features/path_step/widgets/path_progress_pill_row.dart';
import 'package:awwab/src/features/path_step/widgets/path_step_page.dart';
import 'package:awwab/src/features/path_step/widgets/path_step_progress_card.dart';
import 'package:awwab/src/features/path_step/widgets/path_step_top_bar.dart';
import 'package:awwab/src/theme/app_motion.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:awwab/src/widgets/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PathStepScreen extends ConsumerStatefulWidget {
  const PathStepScreen({super.key});

  @override
  ConsumerState<PathStepScreen> createState() => _PathStepScreenState();
}

class _PathStepScreenState extends ConsumerState<PathStepScreen> {
  late final PageController _pageController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _focusNode = FocusNode()..addListener(_onFocusChanged);
  }

  void _onFocusChanged() => setState(() {});

  @override
  void dispose() {
    _focusNode
      ..removeListener(_onFocusChanged)
      ..dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pathStepProvider);
    final notifier = ref.read(pathStepProvider.notifier);
    final media = MediaQuery.of(context);
    final bool keyboardOpen = media.viewInsets.bottom > 0;
    final journey = state.journey;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: ResponsiveContainer(
          maxWidth: 980,
          child: AnimatedPadding(
            duration: const Duration(milliseconds: AppMotion.fastMs),
            curve: Curves.easeOut,
            padding: EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
              keyboardOpen ? AppSpacing.sm : AppSpacing.md,
            ),
            child: Column(
              children: <Widget>[
                PathStepTopBar(
                      title: journey.screenTitle,
                      subtitle: journey.screenSubtitle,
                      onBack: context.pop,
                    )
                    .animate()
                    .fadeIn(duration: AppMotion.normalMs.ms)
                    .slideY(begin: 0.04),
                const SizedBox(height: AppSpacing.lg),
                PathStepProgressCard(
                  journey: journey,
                  currentIndex: state.currentIndex,
                  completionPercent: state.completionPercent,
                  totalXp: state.totalXp,
                ).animate().fadeIn(delay: 60.ms, duration: AppMotion.slowMs.ms),
                const SizedBox(height: AppSpacing.md),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                  ),
                  child: PathProgressPillRow(
                    total: journey.totalSteps,
                    current: state.currentIndex + 1,
                    accent: journey.pathAccent,
                  ),
                ).animate().fadeIn(
                  delay: 90.ms,
                  duration: AppMotion.normalMs.ms,
                ),
                const SizedBox(height: AppSpacing.md),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: journey.steps.length,
                    onPageChanged: notifier.goToStep,
                    itemBuilder: (context, index) {
                      final step = journey.steps[index];
                      final reflection = state.reflections[step.id] ?? '';
                      final taskId = step.task?.id;
                      final taskProgress = taskId == null
                          ? 0
                          : (state.taskProgress[taskId] ?? 0);

                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 260),
                        child: PathStepPage(
                          key: ValueKey<String>(step.id),
                          step: step,
                          reflection: reflection,
                          taskProgress: taskProgress,
                          isCompleting: state.isCompleting,
                          isSaving: state.isSaving,
                          focusNode: _focusNode,
                          onReflectionChanged: (value) =>
                              notifier.updateReflection(
                                step.id,
                                value,
                                step.reflectMax,
                              ),
                          onComplete: () async {
                            await notifier.completeCurrentStep();
                            if (index < journey.steps.length - 1 && mounted) {
                              await _pageController.nextPage(
                                duration: const Duration(milliseconds: 320),
                                curve: Curves.easeOutCubic,
                              );
                            }
                          },
                          onSave: notifier.saveCurrentStep,
                          onTaskIncrement: () {
                            final task = step.task;
                            if (task == null) {
                              return;
                            }
                            notifier.incrementTask(task.id, task.target);
                          },
                          onTaskDecrement: () {
                            final task = step.task;
                            if (task == null) {
                              return;
                            }
                            notifier.decrementTask(task.id);
                          },
                          isSaved: state.savedSteps.contains(step.id),
                          isCompleted: state.completedSteps.contains(step.id),
                        ),
                      );
                    },
                  ),
                ),
                if (!keyboardOpen) ...<Widget>[
                  const SizedBox(height: AppSpacing.md),
                  const HomeBottomNav().animate().fadeIn(
                    delay: 260.ms,
                    duration: AppMotion.normalMs.ms,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
