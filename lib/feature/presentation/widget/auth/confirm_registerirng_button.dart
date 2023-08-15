import 'package:flutter/material.dart';

import '../show_confirm_dialog.dart';

FloatingActionButton confirmRegisteringBottun(
    BuildContext context,
    String fileName,
    Future<DataTable?> Function(BuildContext context) execute) {
  return FloatingActionButton(
    onPressed: () {
      showConfirmDialog(
        context: context,
        titleText: '登録確認',
        contentText: '$fileNameを登録しますか？',
        actions: [
          (contextOnConfirmRegister) => ElevatedButton(
                child: const Text('はい'),
                onPressed: () {
                  Navigator.of(contextOnConfirmRegister).pop();
                  execute(contextOnConfirmRegister).then((result) {
                    if (result == null) {
                      return;
                    } else {
                      showConfirmDialog(
                        context: context,
                        titleText: '登録完了',
                        contentText: '$fileNameを登録しました。',
                        actions: [
                          (context) => ElevatedButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                          (context) => ElevatedButton(
                                child: const Text('表示'),
                                onPressed: () {
                                  showAboutDialog(
                                      context: context, children: [result]);
                                },
                              )
                        ],
                      );
                    }
                  });
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
