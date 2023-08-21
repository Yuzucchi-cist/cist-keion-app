import 'package:auto_route/annotations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/notifier/suggestion/suggestion_list_notifier.dart';
import '../../widget/show_error_dialog.dart';

@RoutePage()
class SuggestionDetailPage extends HookConsumerWidget {
  const SuggestionDetailPage(
      {super.key, @PathParam('suggestionId') required this.suggestionId});

  final String suggestionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('意見箱'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future:
              ref.watch(suggestionListProvider.notifier).getById(suggestionId),
          builder: (context, snapshot) {
            final suggestionState = snapshot.data ?? const AsyncLoading();
            return Center(
              child: suggestionState.when(
                data: (suggestion) => Column(
                  children: [
                    Text(suggestion.category.jpString),
                    AutoSizeText(suggestion.description),
                    Text(suggestion.createdAt!.toIso8601String()),
                  ],
                ),
                error: (error, stackTrace) {
                  showErrorDialog(
                      context: context,
                      titleText: '$error',
                      contentText: '$error');
                  return Text('$error');
                },
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            );
          },
        ));
  }
}
