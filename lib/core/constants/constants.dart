import 'package:flutter/material.dart';

class AppConstants {
  static const double desktopPadding = 10.0;
  static const double tabletPadding = 8.0;
  static const double mobilePadding = 6.0;

  static const double maxContentWidth = 1450.0;

  static double getPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1200) return desktopPadding;
    if (width >= 600) return tabletPadding;
    return mobilePadding;
  }
}
