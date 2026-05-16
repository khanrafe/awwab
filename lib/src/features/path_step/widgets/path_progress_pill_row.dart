import 'package:awwab/src/theme/app_radius.dart';
import 'package:flutter/material.dart';

class PathProgressPillRow extends StatelessWidget {
  const PathProgressPillRow({
    super.key,
    required this.total,
    required this.current,
    required this.accent,
  });

  final int total;
  final int current;
  final Color accent;

  @override
  Widget build(BuildContext context) => Row(
    children: List<Widget>.generate(total, (index) {
      final bool active = index < current;
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(right: index == total - 1 ? 0 : 6),
          height: 10,
          decoration: BoxDecoration(
            color: active ? accent : const Color(0xFFE5E6F2),
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
        ),
      );
    }),
  );
}
