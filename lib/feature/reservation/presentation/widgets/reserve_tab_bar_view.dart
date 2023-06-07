import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../notifier/reserve_table_notifier.dart';
import 'reservation_table.dart';

Widget reserveTabBarView(BuildContext context, WidgetRef ref,
    {bool isAdditionalReservation = false}) {
  final reserveTable = ref.watch(reserveTableForReserveProvider);
  final reserveTableNotifier =
      ref.read(reserveTableForReserveProvider.notifier);
  return Center(
    child: Column(
      children: [
        Expanded(
          child: reservationTable(
            context,
            reserveTable: reserveTable,
            onTap: reserveTableNotifier.onTapped,
          ),
        ),
        ElevatedButton(
          child: Text(
            '予約',
            style: const TextTheme().bodyLarge,
          ),
          onPressed: () {
            if (reserveTableNotifier.isChosen()) {
              context.router.push(MakeReservationDetailRoute(
                  isAdditionalReservation: isAdditionalReservation));
            }
          },
        ),
      ],
    ),
  );
}
