import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';

@RoutePage()
class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(yuzucchi): implement auth
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.router.push(const LoginRoute()),
            icon: const Icon(Icons.login),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Column(
          children: [
            Text('5月7日~5月13日の予約'),
            Placeholder(),
          ],
        ),
      ),
    );
  }
}
