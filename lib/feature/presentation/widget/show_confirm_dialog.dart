import 'package:flutter/material.dart';

void showConfirmDialog(
    {required BuildContext context,
    required String titleText,
    required String contentText,
    List<Widget Function(BuildContext)>? actions}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(titleText),
        content: Text(contentText),
        actions: actions?.map((action) => action(context)).toList(),
      );
    },
  );
}
