import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
void showSnackBar(BuildContext context, String message,
    {MaterialColor? backgroundColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      elevation: 10,
      duration: const Duration(seconds: 1),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
        },
        textColor: Colors.white,
      ),
    ),
  );
}
