import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';

@RoutePage()
class CreateSuggestionPage extends HookConsumerWidget {
  const CreateSuggestionPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(yuzucchi): 認証を追加

    final messageController = useState(TextEditingController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('目安箱'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Form(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                controller: messageController.value,
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'メッセージ',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            TextButton(
              child: Text(
                '確認',
                style: const TextTheme().bodyLarge,
              ),
              onPressed: () =>
                  context.router.push(const ConfirmSuggestionRoute()),
            ),
          ],
        ),
      ),
    );
  }
}
