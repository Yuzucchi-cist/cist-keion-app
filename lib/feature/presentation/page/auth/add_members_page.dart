import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/notifier/auth/member_detail_list_notifier.dart';
import '../../widget/show_confirm_dialog.dart';

@RoutePage()
class AddMembersPage extends HookConsumerWidget {
  const AddMembersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pickedFileName = ref.watch(memberDetailListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('メンバー追加'),
      ),
      body: pickedFileName != ''
          ? Column(
              children: [
                Text('$pickedFileName'),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          showConfirmDialog(
                            context: context,
                            titleText: '登録確認',
                            contentText: '$pickedFileNameを登録しますか？',
                            actions: [
                              (context) => ElevatedButton(
                                    child: const Text('はい'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      showConfirmDialog(
                                        context: context,
                                        titleText: '登録完了',
                                        contentText: '$pickedFileNameを登録しました。',
                                        actions: [
                                          (context) => ElevatedButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  add(ref).then((_) =>
                                                      Navigator.of(context)
                                                          .pop());
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
                                  child: Text('いいえ'))
                            ],
                          );
                        },
                        child: const Text('登録')),
                    ElevatedButton(
                        onPressed: () => pickFile(ref),
                        child: const Text('変更')),
                  ],
                )
              ],
            )
          : ElevatedButton(
              onPressed: () => pickFile(ref), child: const Text('ファイルを選択する')),
    );
  }

  Future<void> pickFile(WidgetRef ref) async {
    ref.read(memberDetailListProvider.notifier).pickFile();
  }

  Future<void> add(WidgetRef ref) async {
    ref.read(memberDetailListProvider.notifier).addToDatabase();
  }
}
