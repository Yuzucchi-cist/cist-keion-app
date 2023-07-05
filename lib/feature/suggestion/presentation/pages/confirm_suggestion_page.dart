import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../notifier/suggestion_notifier.dart';

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
            Text(ref.watch(suggestionProvider)!.description),
            TextButton(
              child: Text(
                '確認',
                style: const TextTheme().bodyLarge,
              ),
              onPressed: () {
                ref.read(suggestionProvider.notifier).add().then((_) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('送信完了'),
                          content: const Text('メッセージの送信が完了しました。'),
                          actions: [
                            ElevatedButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                context.router.push(CreateSuggestionRoute());
                              },
                            )
                          ],
                        );
                      });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
