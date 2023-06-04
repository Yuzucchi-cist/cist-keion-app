import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/reserve_tab_widget.dart';

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
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(text: '予約'),
              Tab(text: '追加予約'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ReserveTabWidget(),
            ReserveTabWidget(
              isAdditionalReservation: true,
            ),
          ],
        ),
      ),
    );
  }
}
