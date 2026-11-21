import 'package:flutter/material.dart';

/// Every color comes from ui-color-palette.xlsx.
class AppColors {
  AppColors._();

  // Background gradient
  static const bgTop = Color(0xFFF6F7FC);
  static const bgMid = Color(0xFFE8ECF8);
  static const bgBottom = Color(0xFFDDD2F4);

  // Primary
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF0B0B0F);
  static const textPrimary = Color(0xFF14141A);
  static const textSecondary = Color(0xFF7B8090);
  static const placeholder = Color(0xFFA3A8B8);
  static const soft = Color(0xFFEEF1FA);

  // Lavender (general info)
  static const lavenderBg = Color(0xFFE4DAF8);
  static const lavender = Color(0xFF8B6FE8);

  // Blue
  static const blueBg = Color(0xFFDCE8FE);
  static const blue = Color(0xFF4C8DF6);

  // Green (verified / normal)
  static const greenBg = Color(0xFFDDF5EA);
  static const green = Color(0xFF2FB67C);
  static const greenText = Color(0xFF1E8E5E);

  // Yellow (pending / warning)
  static const yellowBg = Color(0xFFFFF1D6);
  static const yellow = Color(0xFFF5A524);
  static const yellowText = Color(0xFFB77700);

  // Red (allergy / danger)
  static const redBg = Color(0xFFFDE3E5);
  static const red = Color(0xFFEF5560);
  static const redText = Color(0xFFB52E3A);

  // Extra
  static const navy = Color(0xFF1F2C5C);
  static const avatarBg = Color(0xFFC9D7F8);
  static const dark = Color(0xFF1B2133);
  static const line = Color(0xFFE4E7F0);
  static const toggleOff = Color(0xFFD5D9E6);

  // Translucent white for controls on dark call screens
  static const onDarkSoft = Color(0x26FFFFFF);
}

class AppDecor {
  AppDecor._();

  static const background = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColors.bgTop, AppColors.bgMid, AppColors.bgBottom],
      stops: [0, 0.55, 1],
    ),
  );

  static const darkBackground = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColors.dark, AppColors.textPrimary],
    ),
  );

  static const pagePadding = EdgeInsetsDirectional.fromSTEB(20, 8, 20, 24);
  static const bottomPadding = EdgeInsetsDirectional.fromSTEB(20, 8, 20, 16);
  static const cardPadding = EdgeInsetsDirectional.fromSTEB(16, 14, 16, 14);
}

class AppText {
  AppText._();

  static const h1 = TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.textPrimary);
  static const h2 = TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const label = TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const body = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textPrimary);
  static const caption = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textSecondary);
  static const section = TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary);
  static const onDark = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.white);
  static const onDarkSoft = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.placeholder);
}

class AppTheme {
  AppTheme._();

  static const _pill = StadiumBorder();
  static const _radius20 = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)));
  static const _buttonText = TextStyle(fontFamily: 'Outfit', fontSize: 15, fontWeight: FontWeight.w600);

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Outfit',
      scaffoldBackgroundColor: Colors.transparent,
      colorScheme: const ColorScheme.light(
        primary: AppColors.black,
        onPrimary: AppColors.white,
        secondary: AppColors.lavender,
        surface: AppColors.white,
        onSurface: AppColors.textPrimary,
        error: AppColors.red,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        foregroundColor: AppColors.textPrimary,
        titleTextStyle: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      cardTheme: const CardThemeData(
        color: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: _radius20,
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.lavender,
        titleTextStyle: AppText.label,
        subtitleTextStyle: AppText.caption,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.line, space: 1, thickness: 1),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.toggleOff,
          disabledForegroundColor: AppColors.textSecondary,
          minimumSize: const Size.fromHeight(54),
          elevation: 0,
          shape: _pill,
          textStyle: _buttonText,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.textPrimary,
          minimumSize: const Size.fromHeight(54),
          side: const BorderSide(color: AppColors.line),
          shape: _pill,
          textStyle: _buttonText,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.blue,
          minimumSize: const Size(44, 44),
          textStyle: _buttonText,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        hintStyle: const TextStyle(color: AppColors.placeholder, fontSize: 14),
        labelStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
        contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.blue, width: 1.5),
        ),
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: AppColors.soft,
        selectedColor: AppColors.black,
        disabledColor: AppColors.soft,
        showCheckmark: false,
        side: BorderSide.none,
        shape: StadiumBorder(),
        labelStyle: AppText.label,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: const WidgetStatePropertyAll(AppColors.white),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? AppColors.black : AppColors.toggleOff,
        ),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? AppColors.black : AppColors.white,
        ),
        checkColor: const WidgetStatePropertyAll(AppColors.white),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          side: const WidgetStatePropertyAll(BorderSide.none),
          backgroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? AppColors.black : AppColors.white,
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? AppColors.white : AppColors.textPrimary,
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        indicatorColor: AppColors.lavenderBg,
        height: 68,
        labelTextStyle: const WidgetStatePropertyAll(
          TextStyle(fontFamily: 'Outfit', fontSize: 11, fontWeight: FontWeight.w500),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (s) => IconThemeData(
            color: s.contains(WidgetState.selected) ? AppColors.lavender : AppColors.textSecondary,
          ),
        ),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.black,
        contentTextStyle: TextStyle(fontFamily: 'Outfit', color: AppColors.white),
        behavior: SnackBarBehavior.floating,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.lavender),
    );
  }
}
