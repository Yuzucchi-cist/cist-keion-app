import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../notifier/reserve_table_notifier.dart';
import '../widgets/reserve_tab_bar_view.dart';

@RoutePage()
class ChooseReserveTablePage extends HookConsumerWidget {
  const ChooseReserveTablePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(yuzucchi): 認証を追加
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('予約'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () =>
                  context.router.push(const CancelReservationRoute()),
            )
          ],
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            tabs: const [
              Tab(text: '予約'),
              Tab(text: '追加予約'),
            ],
            onTap: (_) {
              ref.read(reserveTableForReserveProvider.notifier).resetIsTapped();
            },
          ),
        ),
        body: TabBarView(
          children: [
            reserveTabBarView(context, ref),
            reserveTabBarView(
              context,
              ref,
              isAdditionalReservation: true,
            ),
          ],
        ),
      ),
    );
  }
}
