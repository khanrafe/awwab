import 'package:awwab/src/theme/app_radius.dart';
import 'package:awwab/src/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class LogActionReflectionInput extends StatelessWidget {
  const LogActionReflectionInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hint,
    required this.maxLength,
    required this.currentLength,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final int maxLength;
  final int currentLength;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7FF),
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
          TextField(
            controller: controller,
            focusNode: focusNode,
            maxLength: maxLength,
            maxLines: 7,
            minLines: 6,
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
