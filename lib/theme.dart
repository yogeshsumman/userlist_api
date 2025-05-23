import 'package:flutter/material.dart';

ThemeData appTheme() {
  final ColorScheme colorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.indigo,
    accentColor: Colors.amber,
    backgroundColor: Colors.grey[100],
    errorColor: Colors.redAccent,
    brightness: Brightness.light,
  ).copyWith(
    secondary: Colors.teal,
    surface: Colors.white,
  );

  return ThemeData(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.background,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.indigo[800],
      foregroundColor: Colors.white, // Ensure foreground (title, icons) is white
      elevation: 4,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: Colors.white, // Explicitly set title color
      ),
      iconTheme: const IconThemeData(
        color: Colors.white, // Explicitly set icon color to white
        size: 28,
        opacity: 1.0, // Ensure full opacity
      ),
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        letterSpacing: 0.5,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.black87,
        letterSpacing: 0.2,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.grey,
        letterSpacing: 0.2,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    ).apply(
      fontFamily: 'Roboto',
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.indigo, width: 2),
      ),
      labelStyle: const TextStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    iconTheme: IconThemeData(
      color: Colors.indigo[700],
      size: 24,
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.grey,
      thickness: 0.5,
      space: 16,
    ),
  );
}