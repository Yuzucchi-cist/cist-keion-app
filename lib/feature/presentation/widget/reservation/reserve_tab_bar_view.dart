import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../../provider/notifier/reservation/reserve_table_notifier.dart';
import 'reservation_table.dart';

Widget reserveTabBarView(BuildContext context, WidgetRef ref,
    {bool isThisWeek = false, bool isDisplay = false}) {
  final reserveTableProvider = isThisWeek
      ? reserveTableForReserveInThisWeekProvider
      : reserveTableForReserveInNextWeekProvider;
  final reserveTableNotifier = ref.read(reserveTableProvider.notifier);
  return Center(
    child: Column(
      children: isDisplay
          ? [
              Expanded(
                child: reservationTable(
                  context,
                  ref,
                  reserveTableProvider: reserveTableProvider,
                  onTap: isDisplay ? null : reserveTableNotifier.onTapped,
                ),
              ),
            ]
          : [
              Expanded(
                child: reservationTable(
                  context,
                  ref,
                  reserveTableProvider: reserveTableProvider,
                  onTap: isDisplay ? null : reserveTableNotifier.onTapped,
                ),
              ),
              ElevatedButton(
                onPressed: isDisplay
                    ? () {}
                    : () {
                        if (reserveTableNotifier.isChosen()) {
                          context.router.push(MakeReservationDetailRoute(
                              isAdditionalReservation: isThisWeek));
                        }
                      },
                child: Text(
                  '予約',
                  style: const TextTheme().bodyLarge,
                ),
              ),
            ],
    ),
  );
}
