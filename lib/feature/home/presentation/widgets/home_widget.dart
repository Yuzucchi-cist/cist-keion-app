import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../../../reservation/presentation/notifier/reserve_table_notifier.dart';
import '../../../reservation/presentation/widgets/reservation_table.dart';

Widget homeWidget(
    {required BuildContext context,
    required WidgetRef ref,
    bool isAuthenticated = false}) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('ホーム'),
      centerTitle: true,
      actions: isAuthenticated
          ? []
          : [
              IconButton(
                onPressed: () => context.router.push(const AuthRouterRoute()),
                icon: const Icon(Icons.login),
              ),
            ],
      automaticallyImplyLeading: false,
    ),
    body: Center(
      child: reservationTable(context, ref,
          reserveTableProvider: reserveTableInThisWeekProvider),
    ),
  );
}
