import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_shadows.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class PathStepGuidedCard extends StatelessWidget {
  const PathStepGuidedCard({
    super.key,
    required this.title,
    required this.bullets,
  });

  final String title;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(0xFFF0ECFF),
                        child: Icon(
                          Icons.auto_awesome,
                          color: Color(0xFF7A5DFF),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        title,
                        style: textTheme.titleMedium?.copyWith(
                          color: const Color(0xFF6D5CFF),
                          fontWeight: FontWeight.w800,
                          fontSize: 40 * 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ...bullets.map(
                    (line) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Icon(
                              Icons.circle,
                              size: 6,
                              color: Color(0xFF836AFD),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              line,
                              style: textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFF5E6789),
                                fontWeight: FontWeight.w600,
                                height: 1.32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Icon(Icons.air_rounded, size: 98, color: Color(0xFF9E90FF)),
          ],
        ),
      ),
    );
  }
}
