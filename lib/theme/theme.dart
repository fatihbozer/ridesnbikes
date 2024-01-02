import 'package:flutter/material.dart';

ThemeData rideMode = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFB77F3E),
    onPrimary: Color(0xFFCFA472),
    secondary: Color(0xFF3E76B7),
    onSecondary: Color(0xFF729DCF),
    error: Colors.red,
    background: Colors.white,
  ),
  fontFamily: 'Formula1',
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.black),
    displayMedium: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    titleMedium: TextStyle(color: Colors.black),
  ),
);
