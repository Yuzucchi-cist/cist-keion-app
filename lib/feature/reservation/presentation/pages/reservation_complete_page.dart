import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';

@RoutePage()
class ReservationCompletePage extends HookConsumerWidget {
  const ReservationCompletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('予約完了'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
          child: Column(
        children: [
          const Text('予約が完了しました。'),
          TextButton(
            child: const Text('ホームへ'),
            onPressed: () =>
                context.router.push(const ChooseReserveTableRoute()),
          ),
        ],
      )),
    );
  }
}
