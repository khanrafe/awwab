import 'package:awwab/src/features/home/widgets/home_bottom_nav.dart';
import 'package:awwab/src/features/log_action/state/log_action_state.dart';
import 'package:awwab/src/features/log_action/widgets/log_action_category_card.dart';
import 'package:awwab/src/features/log_action/widgets/log_action_intro_card.dart';
import 'package:awwab/src/features/log_action/widgets/log_action_primary_button.dart';
import 'package:awwab/src/features/log_action/widgets/log_action_reflection_input.dart';
import 'package:awwab/src/features/log_action/widgets/log_action_top_bar.dart';
import 'package:awwab/src/theme/app_motion.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:awwab/src/widgets/app_bottom_nav.dart';
import 'package:awwab/src/widgets/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LogActionScreen extends ConsumerStatefulWidget {
  const LogActionScreen({super.key});

  @override
  ConsumerState<LogActionScreen> createState() => _LogActionScreenState();
}

class _LogActionScreenState extends ConsumerState<LogActionScreen> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode()..addListener(_handleFocusChange);
  }

  void _handleFocusChange() => setState(() {});

  @override
  void dispose() {
    _focusNode
      ..removeListener(_handleFocusChange)
      ..dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(logActionProvider);
    final notifier = ref.read(logActionProvider.notifier);
    final model = state.model;
    final textTheme = Theme.of(context).textTheme;
    final media = MediaQuery.of(context);
    final bool keyboardOpen = media.viewInsets.bottom > 0;
    final bool compact = media.size.height < 800 || media.size.width < 390;

    if (_controller.text != state.reflection) {
      _controller.value = _controller.value.copyWith(
        text: state.reflection,
        selection: TextSelection.collapsed(offset: state.reflection.length),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: ResponsiveContainer(
          maxWidth: 980,
          child: AnimatedPadding(
            duration: const Duration(milliseconds: AppMotion.fastMs),
            curve: Curves.easeOut,
            padding: EdgeInsets.fromLTRB(
              compact ? AppSpacing.sm : AppSpacing.md,
              compact ? AppSpacing.sm : AppSpacing.md,
              compact ? AppSpacing.sm : AppSpacing.md,
              keyboardOpen ? AppSpacing.sm : AppSpacing.md,
            ),
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: <Widget>[
                LogActionTopBar(
                      title: model.title,
                      subtitle: model.subtitle,
                      onBack: context.pop,
                    )
                    .animate()
                    .fadeIn(duration: AppMotion.normalMs.ms)
                    .slideY(begin: 0.05),
                SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
                LogActionIntroCard(
                      title: model.bannerTitle,
                      subtitle: model.bannerSubtitle,
                    )
                    .animate()
                    .fadeIn(delay: 70.ms, duration: AppMotion.slowMs.ms)
                    .slideY(begin: 0.05),
                SizedBox(height: compact ? AppSpacing.lg : AppSpacing.xl),
                Text(
                  model.sectionTitle,
                  style: textTheme.titleMedium?.copyWith(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF131C4A),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  model.sectionSubtitle,
                  style: textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF616C90),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final bool rowLayout = constraints.maxWidth >= 620;

                    if (rowLayout) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            model.categories
                                .map(
                                  (category) => Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: AppSpacing.sm,
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 0.78,
                                        child: LogActionCategoryCard(
                                          category: category,
                                          selected:
                                              state.selectedCategoryId ==
                                              category.id,
                                          onTap: () => notifier.selectCategory(
                                            category.id,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList()
                              ..removeLast()
                              ..add(
                                Expanded(
                                  child: AspectRatio(
                                    aspectRatio: 0.78,
                                    child: LogActionCategoryCard(
                                      category: model.categories.last,
                                      selected:
                                          state.selectedCategoryId ==
                                          model.categories.last.id,
                                      onTap: () => notifier.selectCategory(
                                        model.categories.last.id,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      );
                    }

                    return Column(
                      children: model.categories
                          .map(
                            (category) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.sm,
                              ),
                              child: LogActionCategoryCard(
                                category: category,
                                selected:
                                    state.selectedCategoryId == category.id,
                                onTap: () =>
                                    notifier.selectCategory(category.id),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ).animate().fadeIn(
                  delay: 120.ms,
                  duration: AppMotion.normalMs.ms,
                ),
                SizedBox(height: compact ? AppSpacing.lg : AppSpacing.xl),
                Text(
                  model.inputTitle,
                  style: textTheme.titleMedium?.copyWith(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF131C4A),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  model.inputSubtitle,
                  style: textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF616C90),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                LogActionReflectionInput(
                  controller: _controller,
                  focusNode: _focusNode,
                  hint: model.inputHint,
                  maxLength: model.maxCharacters,
                  currentLength: state.reflection.length,
                  onChanged: notifier.updateReflection,
                ).animate().fadeIn(
                  delay: 180.ms,
                  duration: AppMotion.normalMs.ms,
                ),
                SizedBox(height: compact ? AppSpacing.md : AppSpacing.lg),
                LogActionPrimaryButton(
                  label: model.buttonLabel,
                  loading: state.isSubmitting,
                  onPressed: notifier.submit,
                ).animate().fadeIn(
                  delay: 240.ms,
                  duration: AppMotion.normalMs.ms,
                ),
                const SizedBox(height: AppSpacing.md),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        Icons.lock,
                        size: 16,
                        color: Color(0xFFA2A9C4),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        model.securityNote,
                        style: textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF7B84A6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!keyboardOpen) ...<Widget>[
                  SizedBox(height: compact ? AppSpacing.lg : AppSpacing.xl),
                  const HomeBottomNav(activeTab: AppNavTab.tasks)
                      .animate()
                      .fadeIn(delay: 300.ms, duration: AppMotion.normalMs.ms),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
