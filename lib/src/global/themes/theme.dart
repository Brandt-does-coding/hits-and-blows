import 'package:flutter/material.dart';
import 'package:hits_and_blows_game/src/constants/button_styles.dart';

class AppTheme {
  // Primary colors
  static const Color primaryColor = Color(0xFF3F51B5); // Indigo

  static const Color accentColor = Color(0xFFFF9800); // Orange
  static const Color backgroundColor = Color(0xFFF5F5F5); // Light gray
  static const Color darkBackgroundColor = Color(0xFF263238);

  // Game-specific colors
  static const Color correctColor = Color(0xFF4CAF50); // Green
  static const Color hitcolor = Color(0xFFF44336); //Red
  static const Color blowColor = Color(0xFFFFC107); // Amber
  static const Color wrongColor = Color(0xFFE57373); // Light red
  static const Color inputBorderColor = Color(0xFFBDBDBD); // Gray

  // Text colors
  static const Color textPrimary = Color(0xFF212121); // Dark gray
  static const Color textSecondary = Color(0xFF757575); // Medium gray
  static const Color textLight = Color(0xFFFFFFFF); // White

  //Hit and Blow title
  static const TextStyle mainTitleStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: blowColor,
    decoration: TextDecoration.none,
  );
  // Text styles
  static const TextStyle headingLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 18,
    color: textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 16,
    color: textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    color: textSecondary,
  );

  static const TextStyle inputTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  // Theme data
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: primaryButtonStyle),
      outlinedButtonTheme: OutlinedButtonThemeData(style: secondaryButtonStyle),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: inputBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: inputBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
      ),
    );
  }
}
