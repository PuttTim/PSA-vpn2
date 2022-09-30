import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(0xFF4b9795, {
  50: Color.fromRGBO(75, 151, 149, .1),
  100: Color.fromRGBO(75, 151, 149, .1),
  200: Color.fromRGBO(75, 151, 149, .1),
  300: Color.fromRGBO(75, 151, 149, .1),
  400: Color.fromRGBO(75, 151, 149, .1),
  500: Color.fromRGBO(75, 151, 149, .1),
  600: Color.fromRGBO(75, 151, 149, .1),
  700: Color.fromRGBO(75, 151, 149, .1),
  800: Color.fromRGBO(75, 151, 149, .1),
  900: Color.fromRGBO(75, 151, 149, .1),
});

ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: Colors.black,
    secondary: Colors.white,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
    background: Colors.white,
    onBackground: Colors.black,
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: primary,
    onPrimary: Colors.white,
    secondary: Colors.white,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Color(0xff1c1b1f),
    onSurface: Colors.white,
    background: Colors.black,
    onBackground: Colors.white,
  ),
);
