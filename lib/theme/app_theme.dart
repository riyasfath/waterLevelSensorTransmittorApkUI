import 'package:flutter/material.dart';

class AppTheme {
  // Brand colors
  static const Color primary  = Color(0xFF0181D7);
  static const Color textDark = Color(0xFF272A2F);

  // Mock palette
  static const Color kBlueLight = Color(0xFF6DC1FD);
  static const Color kBlueDark  = Color(0xFF095C97);
  static const Color kNavy      = Color(0xFF0C3C74);

  // CTA Button color (#012A6A)
  static const Color kButtonDark = Color(0xFF012A6A);

  // TextField theming
  static const Color kHintColor = Color(0x664F4F4F); // #4F4F4F66
  static const Color kFieldFill = Color(0x42D9D9D9); // #D9D9D942

  // Device tabs border color — you gave #0181D799 (RRGGBBAA) → Flutter ARGB 0x990181D7
  static const Color kDeviceTabBorder = Color(0x990181D7);

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      canvasColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        surface: Colors.white,
        background: Colors.white,
        brightness: Brightness.light,
      ),
    );

    return base.copyWith(
      // AppBar
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: primary,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),

      // Inputs (global TextField look)
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: kFieldFill,
        hintStyle: TextStyle(color: kHintColor),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      ),

      // Surfaces
      cardColor: Colors.white,
      dialogBackgroundColor: Colors.white,
      dividerColor: Color(0xFFE6E8EB),

      // Text defaults
      textTheme: base.textTheme.apply(
        bodyColor: textDark,
        displayColor: textDark,
      ),

      colorScheme: base.colorScheme.copyWith(
        surface: Colors.white,
        background: Colors.white,
      ),
    );
  }
}
