import 'package:awwab/src/theme/app_motion.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:flutter/material.dart';

class PathStepPrimaryButton extends StatelessWidget {
  const PathStepPrimaryButton({
    super.key,
    required this.label,
    required this.loading,
    required this.onPressed,
  });

  final String label;
  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: loading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color(0xFF5E3BFF),
                Color(0xFF7B3FFF),
                Color(0xFF5C3EFF),
              ],
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x335E3BFF),
                blurRadius: 18,
                offset: Offset(0, 7),
              ),
            ],
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: AppMotion.fastMs),
              child: loading
                  ? const SizedBox(
                      key: ValueKey<String>('loading'),
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Row(
                      key: const ValueKey<String>('text'),
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(
                          Icons.check_circle_outline_rounded,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          label,
                          style: textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16.0,
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

class PathStepSecondaryButton extends StatefulWidget {
  const PathStepSecondaryButton({
    super.key,
    required this.label,
    required this.loading,
    required this.onPressed,
  });

  final String label;
  final bool loading;
  final VoidCallback onPressed;

  @override
  State<PathStepSecondaryButton> createState() =>
      _PathStepSecondaryButtonState();
}

class _PathStepSecondaryButtonState extends State<PathStepSecondaryButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.992 : 1,
        duration: const Duration(milliseconds: AppMotion.fastMs),
        child: SizedBox(
          height: 58,
          width: double.infinity,
          child: OutlinedButton(
            onPressed: widget.loading ? null : widget.onPressed,
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFFE4E5F2), width: 1.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: AppMotion.fastMs),
              child: widget.loading
                  ? const SizedBox(
                      key: ValueKey<String>('loading'),
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Row(
                      key: const ValueKey<String>('text'),
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(
                          Icons.event_note_rounded,
                          color: Color(0xFF7B63FF),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.label,
                          style: textTheme.titleMedium?.copyWith(
                            color: const Color(0xFF6C59E3),
                            fontWeight: FontWeight.w800,
                            fontSize: 15.2,
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
