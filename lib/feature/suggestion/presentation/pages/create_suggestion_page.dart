import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../../domain/values/suggestion_category.dart';
import '../notifier/suggestion_notifier.dart';

@RoutePage()
class CreateSuggestionPage extends HookConsumerWidget {
  CreateSuggestionPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(yuzucchi): 認証を追加

    final categoryController = useState<SuggestionCategory?>(null);
    final messageController = useState(TextEditingController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('目安箱'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  DropdownButton(
                      items: SuggestionCategory.values
                          .map((category) => DropdownMenuItem(
                              value: category, child: Text(category.name)))
                          .toList(),
                      value: categoryController.value,
                      onChanged: (value) {
                        categoryController.value = value;
                      }),
                  TextFormField(
                    controller: messageController.value,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'メッセージ',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value != null) {
                        return 'メッセージを入力してください。';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            TextButton(
              child: Text(
                '確認',
                style: const TextTheme().bodyLarge,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final category = categoryController.value!;
                  final description = messageController.value.text;
                  ref
                      .read(suggestionProvider.notifier)
                      .makeSuggestion(category, description);

                  context.router.push(const ConfirmSuggestionRoute());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
