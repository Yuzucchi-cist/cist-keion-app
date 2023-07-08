import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';

@RoutePage()
class AdminPage extends HookConsumerWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('管理用'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => context.navigateTo(const RootRoute()),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('意見箱'),
              onPressed: () {
                context.router.push(const SuggestionsRoute());
              },
            )
          ],
        ),
      ),
    );
  }
}
