import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryGreen = Color(
    0xFF4A6F56,
  ); // Muted sage/forest green
  static const Color beigeBackground = Color(0xFFF7F5F0); // Warm off-white
  static const Color darkBackground = Color(0xFF1C1C1E); // Soft dark
  static const Color darkSlate = Color(0xFF2F3E46);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: beigeBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      surface: beigeBackground,
      onSurface: darkSlate,
    ),
    textTheme: GoogleFonts.outfitTextTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: darkSlate),
      titleTextStyle: TextStyle(
        color: darkSlate,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryGreen,
      brightness: Brightness.dark,
      surface: darkBackground,
    ),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
    ),
  );
}
