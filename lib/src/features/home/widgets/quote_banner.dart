import 'package:awwab/src/features/home/widgets/home_ui_tokens.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class QuoteBanner extends StatelessWidget {
  const QuoteBanner({super.key, required this.quote});

  final String quote;

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
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: <Widget>[
            const CircleAvatar(
              radius: 12,
              backgroundColor: Color(0xFFF2F3FF),
              child: Icon(
                Icons.format_quote_rounded,
                size: 14,
                color: Color(0xFFA19DFF),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                quote,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: HomeUiTokens.subtitleColor,
                  height: 1.25,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Icon(Icons.auto_awesome, color: Color(0xFF9CD9FF), size: 18),
          ],
        ),
      ),
    );
  }
}
