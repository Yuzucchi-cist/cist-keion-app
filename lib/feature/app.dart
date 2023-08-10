import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/router/app_router.dart';
import 'presentation/provider/notifier/auth/auth_notifier.dart';

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChanges = ref.read(authProvider.notifier).authStateChanges();
    return MaterialApp.router(
      routerConfig: ref.watch(appRouterProvider).config(
            reevaluateListenable: ReevaluateListenable.stream(authStateChanges),
          ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
