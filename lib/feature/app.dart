import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/router/app_router.dart';
import 'auth/presentation/notifier/auth_notifier.dart';
import 'reservation/presentation/notifier/reserve_table_notifier.dart';

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    initialize(ref);

    return MaterialApp.router(
      routerConfig: AppRouter().config(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }

  Future<void> initialize(WidgetRef ref) async {
    await ref
        .read(authProvider.notifier)
        .initialize()
        .onError((error, stackTrace) => null);
    await ref
        .read(reserveTableForDisplayInThisWeekProvider.notifier)
        .initialize();
    await ref
        .read(reserveTableForDisplayInNextWeekProvider.notifier)
        .initialize();
    await ref
        .read(reserveTableForReserveInThisWeekProvider.notifier)
        .initialize();
    await ref
        .read(reserveTableForReserveInNextWeekProvider.notifier)
        .initialize();
  }
}
