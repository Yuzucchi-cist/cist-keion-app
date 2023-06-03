import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class MessageCompletePage extends HookConsumerWidget {
  const MessageCompletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('目安箱メッセージ確認'),
      ),
      body: const Center(
        child: Column(
          children: [
            Text(''),
          ],
        ),
      ),
    );
  }
}
