import 'package:flutter/material.dart';

// Funktion um Fehlermeldung anzuzeigen

void displayMessageToUser(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(message),
    ),
  );
}
