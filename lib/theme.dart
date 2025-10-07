import 'package:flutter/material.dart';

// Couleur principale tirée du logo
const primaryRed = Color(0xFFE53935);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Roboto',
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryRed,
    brightness: Brightness.light,
    primary: primaryRed,
    secondary: const Color(0xFF1E88E5), // bleu accent
    surface: Colors.white,
    background: const Color(0xFFF5F5F5),
    error: const Color(0xFFB71C1C),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Roboto',
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryRed,
    brightness: Brightness.dark,
    primary: const Color(0xFFFF6F60), // rouge plus clair en sombre
    secondary: const Color(0xFF90CAF9),
    surface: const Color(0xFF1E1E1E),
    background: const Color(0xFF121212),
    error: const Color(0xFFEF5350),
  ),
);
