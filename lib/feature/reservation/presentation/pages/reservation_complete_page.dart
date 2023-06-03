import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ReservationCompletePage extends HookConsumerWidget {
  const ReservationCompletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('予約完了'),
        centerTitle: true,
      ),
      body: const Center(child: Text('予約が完了しました。')),
    );
  }
}
