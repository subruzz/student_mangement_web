import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: Colors.white,
  ),
  canvasColor: Colors.white,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 22,
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontFamily: 'Montserrat',
    ),
    bodyMedium: TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: 'Montserrat', // Example of using the built-in 'Roboto' font
    ),
    bodySmall: TextStyle(
      fontSize: 19,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: 'Montserrat', // Example of using the built-in 'Roboto' font
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontFamily: 'Montserrat', // Example of using the built-in 'Roboto' font
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: 'Montserrat', // Example of using the built-in 'Roboto' font
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: 'Montserrat', // Example of using the built-in 'Roboto' font
    ),
  ),
);
