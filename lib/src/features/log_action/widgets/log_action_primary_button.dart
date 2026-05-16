import 'package:awwab/src/theme/app_motion.dart';
import 'package:awwab/src/theme/app_radius.dart';
import 'package:flutter/material.dart';

class LogActionPrimaryButton extends StatelessWidget {
  const LogActionPrimaryButton({
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
                        const Icon(Icons.auto_awesome, size: 24),
                        const SizedBox(width: 10),
                        Text(
                          label,
                          style: textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 16.5,
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
