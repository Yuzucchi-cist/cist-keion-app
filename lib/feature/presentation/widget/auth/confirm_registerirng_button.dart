import 'package:flutter/material.dart';

import '../show_confirm_dialog.dart';

ElevatedButton confirmRegisteringBottun(
    BuildContext context, String fileName, Future<void> Function() execute) {
  return ElevatedButton(
    onPressed: () {
      showConfirmDialog(
        context: context,
        titleText: '登録確認',
        contentText: '$fileNameを登録しますか？',
        actions: [
          (context) => ElevatedButton(
                child: const Text('はい'),
                onPressed: () {
                  Navigator.of(context).pop();
                  showConfirmDialog(
                    context: context,
                    titleText: '登録完了',
                    contentText: '$fileNameを登録しました。',
                    actions: [
                      (context) => ElevatedButton(
                            child: const Text('OK'),
                            onPressed: () {
                              execute()
                                  .then((_) => Navigator.of(context).pop());
                            },
                          )
                    ],
                  );
                },
              ),
          (context) => ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('いいえ'))
        ],
      );
    },
    child: const Text('登録'),
  );
}
