import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ConfirmEmailVerifyPage extends ConsumerWidget {
  const ConfirmEmailVerifyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(yuzucchi): 画面の詳細設計

    return Scaffold(
      appBar: AppBar(
        title: const Text('メール認証確認'),
      ),
      body: const Text('認証メールを送信しました。\n'
          '記載されているURLにアクセスして、認証を完了してください。'),
    );
  }
}
