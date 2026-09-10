import 'package:flutter/widgets.dart';

class Responsive {
  static double horizontalPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1200) return 64;
    if (width >= 900) return 40;
    return 20;
  }
}