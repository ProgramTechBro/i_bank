import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF0C00DF);
  static const Color primaryDisabled = Color(0xFFA8A3D7);
  static const Color primaryTint = Color(0xFFF2F1F9);
  static const Color cardIndigoDark = Color(0xFF281C9D);

  static const Color neutral900 = Color(0xFF343434);
  static const Color neutral700 = Color(0xFF898989);
  static const Color neutral500 = Color(0xFF989898);
  static const Color neutral300 = Color(0xFFCACACA);
  static const Color neutral200 = Color(0xFFE0E0E0);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color semanticError = Color(0xFFFF4267);
  static const Color semanticInfo = Color(0xFF0890FE);
  static const Color semanticWarning = Color(0xFFFFAF2A);
  static const Color semanticSuccess = Color(0xFF52D5BA);
  static const Color semanticOrange = Color(0xFFFB6B18);

  static List<BoxShadow> cardShadowPrimary = [
    BoxShadow(
      color: const Color(0x123629B7),
      offset: const Offset(0, 4),
      blurRadius: 30,
    ),
  ];
  static List<BoxShadow> cardShadowNeutral = [
    BoxShadow(
      color: const Color(0x0D000000),
      offset: const Offset(0, 5),
      blurRadius: 30,
    ),
  ];
  static List<BoxShadow> tabBarShadow = [
    BoxShadow(
      color: const Color(0x123629B7),
      offset: const Offset(0, -5),
      blurRadius: 30,
    ),
  ];
}
