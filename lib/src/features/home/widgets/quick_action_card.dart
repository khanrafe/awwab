import 'package:awwab/src/features/home/models/home_dashboard_model.dart';
import 'package:awwab/src/features/home/widgets/home_ui_tokens.dart';
import 'package:awwab/src/theme/app_motion.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class QuickActionCard extends StatefulWidget {
  const QuickActionCard({super.key, required this.action});

  final QuickActionModel action;

  @override
  State<QuickActionCard> createState() => _QuickActionCardState();
}

class _QuickActionCardState extends State<QuickActionCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: AppMotion.fastMs),
        curve: Curves.easeOut,
        scale: _pressed ? 0.985 : 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.md),
          onTap: () {},
          child: Ink(
            padding: const EdgeInsets.all(HomeUiTokens.cardPadding),
            decoration: BoxDecoration(
              color: widget.action.background,
              borderRadius: BorderRadius.circular(AppRadius.md),
              boxShadow: AppShadows.soft,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.78),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(
                    widget.action.icon,
                    color: widget.action.color,
                    size: 30,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.action.title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: HomeUiTokens.titleColor,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  widget.action.subtitle,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: HomeUiTokens.subtitleColor,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white.withValues(alpha: 0.86),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: widget.action.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
