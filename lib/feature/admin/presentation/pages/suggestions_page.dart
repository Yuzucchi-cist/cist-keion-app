import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../suggestion/presentation/widgets/suggestion_list.dart';

@RoutePage()
class SuggestionsPage extends HookConsumerWidget {
  const SuggestionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('意見箱'),
        centerTitle: true,
      ),
      body: Center(child: suggestionList(context, ref)),
    );
  }
}
