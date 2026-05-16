import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class RecoveryPathMetaRow extends StatelessWidget {
  const RecoveryPathMetaRow({
    super.key,
    required this.steps,
    required this.minutes,
  });

  final int steps;
  final int minutes;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: <Widget>[
        const Icon(Icons.schedule_rounded, size: 18, color: Color(0xFF9AA2BE)),
        const SizedBox(width: AppSpacing.xs),
        Text(
          '$steps steps',
          style: textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF7982A4),
            fontWeight: FontWeight.w600,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text('•', style: TextStyle(color: Color(0xFF9AA2BE))),
        ),
        Text(
          '~$minutes min',
          style: textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF7982A4),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
