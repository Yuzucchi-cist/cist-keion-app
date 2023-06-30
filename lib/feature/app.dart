import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/router/app_router.dart';
import 'auth/presentation/notifier/auth_notifier.dart';
import 'reservation/presentation/notifier/reserve_table_notifier.dart';

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(authProvider.notifier)
        .initialize()
        .onError((error, stackTrace) {});
    ref.read(reserveTableInThisWeekProvider.notifier).initialize();
    ref.read(reserveTableInNextWeekProvider.notifier).initialize();

    return MaterialApp.router(
      routerConfig: ref.watch(appRouterProvider).config(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
