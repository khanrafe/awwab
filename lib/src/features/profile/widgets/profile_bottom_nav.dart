import 'package:awwab/src/widgets/app_bottom_nav.dart';
import 'package:flutter/material.dart';

class ProfileBottomNav extends StatelessWidget {
  const ProfileBottomNav({super.key});

  @override
  Widget build(BuildContext context) =>
      const AppBottomNav(activeTab: AppNavTab.profile);
}
