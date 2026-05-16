import 'package:awwab/src/features/path_step/models/path_step_model.dart';
import 'package:awwab/src/theme/app_motion.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class SpiritualTaskCard extends StatelessWidget {
  const SpiritualTaskCard({
    super.key,
    required this.task,
    required this.current,
    required this.onIncrement,
    required this.onDecrement,
  });

  final SpiritualTaskModel task;
  final int current;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    switch (task.type) {
      case RecoveryTaskType.tasbihCounter:
        return _CounterTask(
          task: task,
          current: current,
          onIncrement: onIncrement,
          onDecrement: onDecrement,
        );
      case RecoveryTaskType.breathing:
        return _CounterTask(
          task: task,
          current: current,
          onIncrement: onIncrement,
          onDecrement: onDecrement,
          icon: Icons.air_rounded,
        );
      case RecoveryTaskType.gratitude:
        return _CounterTask(
          task: task,
          current: current,
          onIncrement: onIncrement,
          onDecrement: onDecrement,
          icon: Icons.favorite_outline_rounded,
        );
      case RecoveryTaskType.mindfulness:
        return _CounterTask(
          task: task,
          current: current,
          onIncrement: onIncrement,
          onDecrement: onDecrement,
          icon: Icons.self_improvement_rounded,
        );
    }
  }
}

class _CounterTask extends StatefulWidget {
  const _CounterTask({
    required this.task,
    required this.current,
    required this.onIncrement,
    required this.onDecrement,
    this.icon = Icons.auto_awesome,
  });

  final SpiritualTaskModel task;
  final int current;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final IconData icon;

  @override
  State<_CounterTask> createState() => _CounterTaskState();
}

class _CounterTaskState extends State<_CounterTask> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final double progress = widget.current / widget.task.target;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F7FF),
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: AppShadows.soft,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 90,
              height: 90,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: progress),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) => CircularProgressIndicator(
                      value: value,
                      strokeWidth: 7,
                      backgroundColor: const Color(0xFFE8E8F7),
                      color: const Color(0xFF7A5DFF),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        widget.icon,
                        color: const Color(0xFF775CF3),
                        size: 24,
                      ),
                      Text(
                        '${widget.current}',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF2A2A62),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.task.title,
                    style: textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF6D5CFF),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    widget.task.subtitle,
                    style: textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF5E6789),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${widget.current} / ${widget.task.target}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF7A83A4),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              children: <Widget>[
                IconButton(
                  onPressed: widget.onDecrement,
                  icon: const Icon(Icons.remove_circle_outline_rounded),
                  color: const Color(0xFF7D85A8),
                ),
                GestureDetector(
                  onTapDown: (_) => setState(() => _pressed = true),
                  onTapUp: (_) => setState(() => _pressed = false),
                  onTapCancel: () => setState(() => _pressed = false),
                  child: AnimatedScale(
                    scale: _pressed ? 0.95 : 1,
                    duration: const Duration(milliseconds: AppMotion.fastMs),
                    child: FloatingActionButton.small(
                      onPressed: widget.onIncrement,
                      elevation: 0,
                      backgroundColor: const Color(0xFF7659FF),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
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
