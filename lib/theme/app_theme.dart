import 'package:flutter/material.dart';

class AppTheme {
  // Brand colors
  static const Color primary = Color(0xFF0181D7);
  static const Color textDark = Color(0xFF272A2F);

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      // 👇 Make all screens (incl. Dashboard) pure white by default
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
      // Keep app bar solid brand color, no tint
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: primary,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      // Ensure cards/dialogs don’t add gray surface tints
      cardColor: Colors.white,
      dialogBackgroundColor: Colors.white,
      dividerColor: const Color(0xFFE6E8EB),
      // Text color defaults
      textTheme: base.textTheme.apply(
        bodyColor: textDark,
        displayColor: textDark,
      ),
      // Double-ensure Material 3 surfaces stay white
      colorScheme: base.colorScheme.copyWith(
        surface: Colors.white,
        background: Colors.white,
      ),
    );
  }
}
