import 'package:flutter/material.dart';

class SnackbarUtils {
  BuildContext context;
  SnackbarUtils({required this.context});

  void createSnackbar(String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: "OKAY",
          onPressed: () {},
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}