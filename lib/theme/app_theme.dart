import 'package:flutter/material.dart';

class AppTheme {
  // Brand colors (single solid app bar color)
  static const Color primary = Color(0xFF0181D7); // <- your app bar color
  static const Color surface = Color(0xFFF6F7FB);
  static const Color card = Colors.white;
  static const Color primaryTransparent = Color(0x990181D7); // #0181D799


  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: surface,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        surface: surface,
        background: surface,
        brightness: Brightness.light,
      ),
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: primary,   // <- used by our header
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: Color(0xFF272A2F),
        displayColor: Color(0xFF272A2F),
      ),
      chipTheme: base.chipTheme.copyWith(
        selectedColor: primary,
        backgroundColor: Color(0xFFE7F3FF),
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      cardTheme: CardTheme(
        color: card,
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
