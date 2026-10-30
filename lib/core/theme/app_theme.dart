// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBg,
      primaryColor: AppColors.gold,
      colorScheme: ColorScheme.dark(
        primary: AppColors.gold,
        secondary: AppColors.goldAccent,
        surface: AppColors.darkCard,
        background: AppColors.darkBg,
        onSurface: AppColors.darkText,
        onSurfaceVariant: AppColors.darkMutedText,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme,
      ).apply(bodyColor: AppColors.darkText, displayColor: AppColors.darkText),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.darkText),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.darkBorder, width: 0.5),
        ),
        elevation: 0,
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.darkBorder,
        thickness: 0.5,
      ),
    );
  }

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBg,
      primaryColor: AppColors.gold,
      colorScheme: ColorScheme.light(
        primary: AppColors.gold,
        secondary: AppColors.goldAccent,
        surface: AppColors.lightCard,
        background: AppColors.lightBg,
        onSurface: AppColors.lightText,
        onSurfaceVariant: AppColors.lightMutedText,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
          .apply(
            bodyColor: AppColors.lightText,
            displayColor: AppColors.lightText,
          ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.lightText),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.lightBorder, width: 0.5),
        ),
        elevation: 0,
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.lightBorder,
        thickness: 0.5,
      ),
    );
  }
}
