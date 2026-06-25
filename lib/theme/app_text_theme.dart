
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextTheme {
  static const String fontFamily = 'peyda';
  static TextTheme textTheme = TextTheme(
     // Headings Bold
    displayLarge: TextStyle(
        // headingBold1
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        color: AppColors.white),
    displayMedium: TextStyle(
        // headingBold2
        fontSize: 18,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        color: AppColors.white),
    displaySmall: TextStyle(
        // headingBold3
        fontSize: 16,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        color: AppColors.white),

    // Headings SemiBold
    headlineMedium: TextStyle(
        // headingSemiBold1
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily,
        color: AppColors.white),
    headlineSmall: TextStyle(
        // headingSemiBold2
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily,
        color: AppColors.white),

    // Continue with other sizes
    titleLarge: TextStyle(
        // headingBold4
        fontSize: 14,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        color: AppColors.white),
    titleMedium: TextStyle(
        // headingBold5
        fontSize: 12,
        fontWeight: FontWeight.w700,
        fontFamily: fontFamily,
        color: AppColors.white),
    titleSmall: TextStyle(
        // headingSemiBold3
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily,
        color: AppColors.white),

    // Body Styles
    bodyLarge: TextStyle(
        // body1
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        color: AppColors.white),
    bodyMedium: TextStyle(
        // body2R
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        color: AppColors.white),
    bodySmall: TextStyle(
        // body3R
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        color: AppColors.white),

    // Extra custom fields (manual use if needed)
    labelLarge: TextStyle(
        // body2M
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: fontFamily,
        color: AppColors.white),
    labelMedium: TextStyle(
        // body3M
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        color: AppColors.white),
    labelSmall: TextStyle(
        // body4M
        fontSize: 10,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily,
        color: AppColors.white),

  );
}
