import 'package:flutter/material.dart';
import 'package:online_exam_app/core/utiles/app_color.dart';

abstract class AppTheme {
  static ThemeData getTheme({
    required ColorScheme colorScheme,
    required Color textFieldBorderColor,
  }) {
    return ThemeData(
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        foregroundColor: colorScheme.secondary,
      ),

      textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: 16, color: colorScheme.secondary),
        bodyMedium: TextStyle(fontSize: 14, color: colorScheme.secondary),
        bodySmall: TextStyle(fontSize: 12, color: colorScheme.secondary),
        titleLarge: TextStyle(fontSize: 20, color: colorScheme.secondary),
        titleMedium: TextStyle(fontSize: 18, color: colorScheme.secondary),
        titleSmall: TextStyle(fontSize: 16, color: colorScheme.secondary),
      ),

      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: textFieldBorderColor, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: textFieldBorderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: textFieldBorderColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
      ),
    );
  }

  static ThemeData lightTheme = getTheme(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.blue,
      onPrimary: AppColors.white,
      secondary: AppColors.black,
      onSecondary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.blue,
    ),
    textFieldBorderColor: AppColors.darkGray,
  );
}