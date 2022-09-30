import 'package:flutter/material.dart';

class CustomTheme {
  static MaterialColor primary = const MaterialColor(0xFF4b9795, {
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

  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: Colors.black,
      secondary: CustomTheme.primary.withGreen(130),
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
      background: Colors.white,
      onBackground: Colors.black,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: Colors.white,
      secondary: CustomTheme.primary.withGreen(130),
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: const Color(0xff1c1b1f),
      onSurface: Colors.white,
      background: Colors.black,
      onBackground: Colors.white,
    ),
  );
}
