import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';

@RoutePage()
class ConfirmEmailVerifyPage extends ConsumerWidget {
  const ConfirmEmailVerifyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(yuzucchi): 画面の詳細設計

    return Scaffold(
      appBar: AppBar(
        title: const Text('メール認証確認'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () =>
              context.navigateTo(const RootRoute(children: [HomeRoute()])),
        ),
      ),
      body: Column(
        children: [
          const Text('認証メールを送信しました。\n'
              '記載されているURLにアクセスして、認証を完了してください。'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Text('ログイン'),
                onPressed: () => context.router.push(const LoginRoute()),
              ),
            ],
          )
        ],
      ),
    );
  }
}
