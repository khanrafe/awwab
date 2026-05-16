import 'package:awwab/src/widgets/app_bottom_nav.dart';
import 'package:flutter/material.dart';

class ProgressBottomNav extends StatelessWidget {
  const ProgressBottomNav({super.key});

  @override
  Widget build(BuildContext context) =>
      const AppBottomNav(activeTab: AppNavTab.progress);
}
