// lib/core/utils/screen_utils.dart
import 'package:flutter/material.dart';

class ScreenUtils {
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  static double getSafeAreaHeight(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.height - mediaQuery.padding.top - mediaQuery.padding.bottom;
  }

  static bool isTablet(BuildContext context) {
    final screenWidth = getScreenWidth(context);
    return screenWidth >= 600;
  }

  static bool isCompactHeight(BuildContext context) {
    return getSafeAreaHeight(context) < 500;
  }

  static double responsiveValue(
    BuildContext context, {
    required double mobile,
    required double tablet,
  }) {
    return isTablet(context) ? tablet : mobile;
  }
}
