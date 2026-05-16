import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class PathStepReflectionInput extends StatelessWidget {
  const PathStepReflectionInput({
    super.key,
    required this.focusNode,
    required this.hint,
    required this.maxLength,
    required this.currentLength,
    required this.initialValue,
    required this.onChanged,
  });

  final FocusNode focusNode;
  final String hint;
  final int maxLength;
  final int currentLength;
  final String initialValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FF),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: focusNode.hasFocus
              ? const Color(0xFF8B6CFF)
              : const Color(0xFFE5E6F3),
          width: focusNode.hasFocus ? 1.4 : 1,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Column(
        children: <Widget>[
          TextFormField(
            key: ValueKey<String>(initialValue),
            initialValue: initialValue,
            focusNode: focusNode,
            maxLength: maxLength,
            maxLines: 6,
            minLines: 5,
            keyboardType: TextInputType.multiline,
            onChanged: onChanged,
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF202A55),
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
              hintText: hint,
              hintStyle: textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF8C92AF),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '$currentLength / $maxLength',
              style: textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF6F789A),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
