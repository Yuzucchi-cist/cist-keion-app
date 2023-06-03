import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ConfirmSuggestionPage extends HookConsumerWidget {
  const ConfirmSuggestionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('送信メッセージの確認'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Text('〇〇を改善してほしい。'),
            TextButton(
              onPressed: () {},
              child: Text(
                '確認',
                style: const TextTheme().bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
