import 'package:awwab/src/features/recovery_paths/models/recovery_paths_model.dart';
import 'package:awwab/src/features/recovery_paths/widgets/recovery_path_meta_row.dart';
import 'package:awwab/src/theme/app_motion.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class RecommendedRecoveryPathCard extends StatelessWidget {
  const RecommendedRecoveryPathCard({
    super.key,
    required this.path,
    required this.onTap,
  });

  final RecoveryPathModel path;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border(left: BorderSide(color: path.accent, width: 4)),
            boxShadow: AppShadows.soft,
          ),
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 78,
                    height: 78,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: path.softBackground,
                    ),
                    child: Icon(path.icon, color: path.accent, size: 42),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          path.title,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 18.5,
                            color: const Color(0xFF131C4A),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          path.subtitle,
                          style: textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF596286),
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        RecoveryPathMetaRow(
                          steps: path.steps,
                          minutes: path.estimatedMinutes,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _ContinueButton(accent: path.accent, onTap: onTap),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: path.progress),
                      duration: const Duration(milliseconds: 650),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, _) => ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        child: LinearProgressIndicator(
                          value: value,
                          minHeight: 8,
                          backgroundColor: const Color(0xFFEAECF6),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            path.accent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    'Step ${path.stepNumber} of ${path.steps}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF727B9D),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContinueButton extends StatefulWidget {
  const _ContinueButton({required this.accent, required this.onTap});

  final Color accent;
  final VoidCallback onTap;

  @override
  State<_ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<_ContinueButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTapDown: (_) => setState(() => _pressed = true),
    onTapCancel: () => setState(() => _pressed = false),
    onTapUp: (_) => setState(() => _pressed = false),
    child: AnimatedScale(
      scale: _pressed ? 0.98 : 1,
      duration: const Duration(milliseconds: AppMotion.fastMs),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.pill),
        onTap: widget.onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            gradient: LinearGradient(
              colors: <Color>[
                widget.accent,
                widget.accent.withValues(alpha: 0.82),
              ],
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: widget.accent.withValues(alpha: 0.28),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
