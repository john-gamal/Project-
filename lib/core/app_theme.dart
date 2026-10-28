import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF5235EA);
  static const fill = Color(0xFFF4F2FE);
  static const border = Color(0xFFE3DEFA);
  static const text = Color(0xFF14123A);
  static const muted = Color(0xFF6B6A8A);
}

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
    ),
    scaffoldBackgroundColor: AppColors.primary,
    textTheme: ThemeData.light().textTheme.apply(
      bodyColor: AppColors.text,
      displayColor: AppColors.text,
    ),
  );
}
