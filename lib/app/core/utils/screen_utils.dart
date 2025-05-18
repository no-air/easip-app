import 'package:flutter/material.dart';

class ScreenUtils {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getSafeAreaHeight(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return getScreenHeight(context) - padding.top - padding.bottom;
  }

  static double ratioWidth(BuildContext context, double ratio) {
    return ScreenUtils.getScreenWidth(context) * ratio / 373;
  }

  static double ratioHeight(BuildContext context, double ratio) {
    return ScreenUtils.getScreenWidth(context) * ratio / 812;
  }
} 