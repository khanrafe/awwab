import 'package:awwab/src/widgets/app_bottom_nav.dart';
import 'package:flutter/material.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key, this.activeTab = AppNavTab.home});

  final AppNavTab activeTab;

  @override
  Widget build(BuildContext context) => AppBottomNav(activeTab: activeTab);
}
