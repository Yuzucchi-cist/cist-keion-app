import 'package:auto_route/annotations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/notifier/suggestion/suggestion_list_notifier.dart';

@RoutePage()
class SuggestionDetailPage extends HookConsumerWidget {
  const SuggestionDetailPage(this.suggestionId, {super.key});

  final String suggestionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final suggestion =
        ref.watch(suggestionListProvider.notifier).getById(suggestionId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('意見箱'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(suggestion.category.jpString),
            AutoSizeText(suggestion.description),
            Text(suggestion.createdAt!.toIso8601String()),
          ],
        ),
      ),
    );
  }
}
