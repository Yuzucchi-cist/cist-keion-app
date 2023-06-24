import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/router/app_router.dart';
import 'auth/presentation/notifier/auth_notifier.dart';

class App extends HookConsumerWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(authProvider.notifier).initialize();

    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
