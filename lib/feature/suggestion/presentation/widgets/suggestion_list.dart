import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../notifier/suggestion_list_notifier.dart';

const _descriptionLabelMaxLength = 10;

Widget suggestionList(BuildContext context, WidgetRef ref) {
  return FutureBuilder(
      future: ref.read(suggestionListProvider.notifier).getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = snapshot.data;
        if (data != null) {
          data.sort((a, b) {
            final cResult = a.category.index - b.category.index;
            return cResult == 0
                ? a.createdAt!.compareTo(b.createdAt!)
                : cResult;
          });
          return Column(
            children: data.map((suggestion) {
              final description =
                  suggestion.description.length < _descriptionLabelMaxLength
                      ? suggestion.description
                      : suggestion.description
                          .substring(0, _descriptionLabelMaxLength - 1);
              return Row(
                children: [
                  Text('${suggestion.category.jpString.padRight(6)}: '),
                  ElevatedButton(
                    child: Text(description),
                    onPressed: () {
                      context.router.push(
                          SuggestionDetailRoute(suggestionId: suggestion.id));
                    },
                  ),
                  Text('${suggestion.createdAt}'),
                ],
              );
            }).toList(),
          );
        }
        return const Text('ERROR!!!');
      });
}
