import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/router/app_router.dart';
import 'presentation/provider/notifier/auth/auth_notifier.dart';

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: initialize(ref),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp.router(
            routerConfig: ref.watch(appRouterProvider).config(),
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
          );
        } else {
          // show loading
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<void> initialize(WidgetRef ref) async {
    await Future.delayed(const Duration(seconds: 5));
    await ref.read(authProvider.notifier).build();
  }
}
