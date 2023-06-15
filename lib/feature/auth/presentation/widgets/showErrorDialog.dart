import 'package:flutter/material.dart';

void showErrorDialog(
    {required BuildContext context,
    required String titleText,
    required String contentText}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          title: Text(titleText),
          content: Text(contentText),
          actions: [
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ]);
    },
  );
}
