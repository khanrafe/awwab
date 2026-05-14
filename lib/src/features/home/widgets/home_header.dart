import 'package:awwab/src/features/home/widgets/home_ui_tokens.dart';
import 'package:awwab/src/theme/app_colors.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'avvab',
              style: textTheme.headlineMedium?.copyWith(
                fontSize: 56 * 0.38,
                height: 1,
                letterSpacing: -0.8,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0D1654),
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              'Your Recovery System',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary.withValues(alpha: 0.86),
                fontWeight: FontWeight.w600,
                fontSize: 14,
                height: 1.2,
              ),
            ),
          ],
        ),
        const Spacer(),
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                boxShadow: AppShadows.soft,
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings_outlined),
                splashRadius: 22,
                color: HomeUiTokens.titleColor,
              ),
            ),
            const Positioned(
              right: 8,
              top: -2,
              child: CircleAvatar(
                radius: 4,
                backgroundColor: Color(0xFF8D63FF),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
