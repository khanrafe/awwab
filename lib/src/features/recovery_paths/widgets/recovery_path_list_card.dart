import 'package:awwab/src/features/recovery_paths/models/recovery_paths_model.dart';
import 'package:awwab/src/features/recovery_paths/widgets/recovery_path_meta_row.dart';
import 'package:awwab/src/theme/app_motion.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class RecoveryPathListCard extends StatefulWidget {
  const RecoveryPathListCard({
    super.key,
    required this.path,
    required this.selected,
    required this.onTap,
  });

  final RecoveryPathModel path;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<RecoveryPathListCard> createState() => _RecoveryPathListCardState();
}

class _RecoveryPathListCardState extends State<RecoveryPathListCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.99 : 1,
        duration: const Duration(milliseconds: AppMotion.fastMs),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.md),
            onTap: widget.onTap,
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border(
                  left: BorderSide(color: widget.path.accent, width: 3),
                ),
                boxShadow: AppShadows.soft,
              ),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 74,
                    height: 74,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.path.softBackground,
                    ),
                    child: Icon(
                      widget.path.icon,
                      color: widget.path.accent,
                      size: 38,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.path.title,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 42 * 0.52,
                            color: const Color(0xFF131C4A),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          widget.path.subtitle,
                          style: textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF596286),
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        RecoveryPathMetaRow(
                          steps: widget.path.steps,
                          minutes: widget.path.estimatedMinutes,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.selected
                          ? widget.path.accent.withValues(alpha: 0.14)
                          : const Color(0xFFF9FAFF),
                      boxShadow: AppShadows.soft,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: widget.selected
                          ? widget.path.accent
                          : const Color(0xFF7D85A8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
