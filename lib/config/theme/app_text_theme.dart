import 'package:flutter/material.dart';
import '../app_typography.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme get textTheme {
    return const TextTheme(
      titleLarge: AppTypography.title1SemiBold,
      titleMedium: AppTypography.title2SemiBold,
      titleSmall: AppTypography.title3SemiBold,
      bodyLarge: AppTypography.bodyRegular,
      bodyMedium: AppTypography.bodyMedium,
      labelLarge: AppTypography.bodySmallMedium,
      bodySmall: AppTypography.captionMedium,
      labelSmall: AppTypography.captionSemiBold,
    );
  }
}
