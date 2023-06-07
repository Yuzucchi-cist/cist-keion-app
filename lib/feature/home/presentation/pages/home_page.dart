import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../reservation/presentation/widgets/reservation_table.dart';

@RoutePage()
class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(yuzucchi): implement auth
    final startDateOfWeek = getStartDateOfThisWeek();
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.router.push(const AuthRouterRoute()),
            icon: const Icon(Icons.login),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: FittedBox(
                    child: reservationTable(startDateOfWeek: startDateOfWeek))),
          ],
        ),
      ),
    );
  }
}
