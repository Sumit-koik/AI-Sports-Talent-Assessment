import 'package:flutter/material.dart';

class AppTheme {
  static const _green = Color(0xFF176B45);
  static const _lime = Color(0xFFB9E769);

  static ThemeData get light => _buildTheme(Brightness.light);
  static ThemeData get dark => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: _green,
      brightness: brightness,
      primary: isDark ? _lime : _green,
      surface: isDark ? const Color(0xFF121814) : const Color(0xFFF7F8F3),
    );
    return ThemeData(
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      useMaterial3: true,
      textTheme: _textTheme(brightness),
      filledButtonTheme: FilledButtonThemeData(style: FilledButton.styleFrom(minimumSize: const Size(0, 52), padding: const EdgeInsets.symmetric(horizontal: 20), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), textStyle: const TextStyle(fontWeight: FontWeight.w700))),
      outlinedButtonTheme: OutlinedButtonThemeData(style: OutlinedButton.styleFrom(minimumSize: const Size(0, 52), padding: const EdgeInsets.symmetric(horizontal: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), textStyle: const TextStyle(fontWeight: FontWeight.w700))),
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(minimumSize: const Size(48, 44), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), textStyle: const TextStyle(fontWeight: FontWeight.w700))),
      appBarTheme: AppBarTheme(backgroundColor: scheme.surface, foregroundColor: scheme.onSurface, elevation: 0),
      cardTheme: CardThemeData(color: isDark ? const Color(0xFF1C261F) : Colors.white, elevation: 0, margin: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: isDark ? const Color(0xFF1C261F) : Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none)),
    );
  }

  static TextTheme _textTheme(Brightness brightness) {
    final color = brightness == Brightness.dark ? Colors.white : const Color(0xFF17211B);
    return TextTheme(
      displaySmall: TextStyle(fontSize: 34, fontWeight: FontWeight.w800, color: color),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: color),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: color),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: color),
      bodyLarge: TextStyle(fontSize: 16, height: 1.4, color: color),
      bodyMedium: TextStyle(fontSize: 14, height: 1.35, color: color.withValues(alpha: .72)),
      labelLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
    );
  }
}