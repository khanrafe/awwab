import 'package:awwab/src/features/path_step/models/path_step_model.dart';
import 'package:awwab/src/features/path_step/widgets/path_step_action_buttons.dart';
import 'package:awwab/src/features/path_step/widgets/path_step_guided_card.dart';
import 'package:awwab/src/features/path_step/widgets/path_step_reflection_input.dart';
import 'package:awwab/src/features/path_step/widgets/spiritual_task_card.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class PathStepPage extends StatelessWidget {
  const PathStepPage({
    super.key,
    required this.step,
    required this.reflection,
    required this.taskProgress,
    required this.isCompleting,
    required this.isSaving,
    required this.focusNode,
    required this.onReflectionChanged,
    required this.onComplete,
    required this.onSave,
    required this.onTaskIncrement,
    required this.onTaskDecrement,
    required this.isSaved,
    required this.isCompleted,
  });

  final RecoveryStepModel step;
  final String reflection;
  final int taskProgress;
  final bool isCompleting;
  final bool isSaving;
  final FocusNode focusNode;
  final ValueChanged<String> onReflectionChanged;
  final VoidCallback onComplete;
  final VoidCallback onSave;
  final VoidCallback onTaskIncrement;
  final VoidCallback onTaskDecrement;
  final bool isSaved;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'TODAY\'S STEP',
                    style: textTheme.titleMedium?.copyWith(
                      fontSize: 14.8,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF6D5CFF),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    step.title,
                    style: textTheme.headlineMedium?.copyWith(
                      fontSize: 25.5,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF131C4A),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    step.description,
                    style: textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF5F6788),
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isSaved ? const Color(0xFFECE9FF) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x120E1442),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.bookmark_rounded,
                color: isSaved
                    ? const Color(0xFF6A52E2)
                    : const Color(0xFF7A5DFF),
                size: 28,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        PathStepGuidedCard(
          title: step.guidedTitle,
          bullets: step.guidedBullets,
        ),
        if (step.task != null) ...<Widget>[
          const SizedBox(height: AppSpacing.md),
          SpiritualTaskCard(
            task: step.task!,
            current: taskProgress,
            onIncrement: onTaskIncrement,
            onDecrement: onTaskDecrement,
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        Text(
          step.reflectTitle,
          style: textTheme.titleMedium?.copyWith(
            fontSize: 16.5,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF131C4A),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          step.reflectSubtitle,
          style: textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF616C90),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        PathStepReflectionInput(
          focusNode: focusNode,
          hint: step.reflectHint,
          maxLength: step.reflectMax,
          currentLength: reflection.length,
          initialValue: reflection,
          onChanged: onReflectionChanged,
        ),
        const SizedBox(height: AppSpacing.lg),
        PathStepPrimaryButton(
          label: isCompleted ? 'Completed' : step.completeLabel,
          loading: isCompleting,
          onPressed: onComplete,
        ),
        const SizedBox(height: AppSpacing.sm),
        PathStepSecondaryButton(
          label: step.saveLabel,
          loading: isSaving,
          onPressed: onSave,
        ),
      ],
    );
  }
}
