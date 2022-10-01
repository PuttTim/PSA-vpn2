import 'package:flutter/material.dart';

class CustomTheme {
  static MaterialColor primary = const MaterialColor(0xFF4b9795, {
    50: Color.fromRGBO(75, 151, 149, .1),
    100: Color.fromRGBO(75, 151, 149, .2),
    200: Color.fromRGBO(75, 151, 149, .3),
    300: Color.fromRGBO(75, 151, 149, .4),
    400: Color.fromRGBO(75, 151, 149, .5),
    500: Color.fromRGBO(75, 151, 149, .6),
    600: Color.fromRGBO(75, 151, 149, .7),
    700: Color.fromRGBO(75, 151, 149, .8),
    800: Color.fromRGBO(75, 151, 149, .9),
    900: Color.fromRGBO(75, 151, 149, 1),
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

  static Color getbaseColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[800]!
        : Colors.grey[300]!;
  }

  static Color gethighlightColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[600]!
        : Colors.grey[100]!;
  }
}
