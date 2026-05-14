import 'package:flutter/widgets.dart';

abstract final class ResponsiveBreakpoints {
  static const tablet = 768.0;
  static const desktop = 1024.0;

  static bool isTabletOrLarger(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= tablet;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= desktop;
  }
}
