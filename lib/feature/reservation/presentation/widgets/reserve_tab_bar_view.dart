import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/utils/date_time_utils.dart';
import 'reservation_table.dart';

Widget reserveTabBarView(BuildContext context,
    {bool isAdditionalReservation = false}) {
  final startDateOfWeek = isAdditionalReservation
      ? getStartDateOfThisWeek()
      : getStartDateOfThisWeek()
          .add(const Duration(days: DateTime.daysPerWeek));

  return Center(
    child: Column(
      children: [
        Expanded(
          child: FittedBox(
              child: reservationTable(startDateOfWeek: startDateOfWeek)),
        ),
        ElevatedButton(
          child: Text(
            '予約',
            style: const TextTheme().bodyLarge,
          ),
          onPressed: () =>
              context.router.push(const MakeReservationDetailRoute()),
        ),
      ],
    ),
  );
}
