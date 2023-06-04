import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import 'reserve_table_widget.dart';

class ReserveTabWidget extends HookConsumerWidget {
  const ReserveTabWidget({super.key, this.isAdditionalReservation = false});

  final bool isAdditionalReservation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final today = DateTime.now();
    final startDateOfWeek = isAdditionalReservation
        ? today.subtract(Duration(days: today.weekday % DateTime.daysPerWeek))
        : today
            .subtract(Duration(days: today.weekday % DateTime.daysPerWeek))
            .add(const Duration(days: DateTime.daysPerWeek));

    return Center(
      child: Column(
        children: [
          Expanded(
            child: FittedBox(
                child: ReserveTableWidget(startDateOfWeek: startDateOfWeek)),
          ),
          TextButton(
            onPressed: () =>
                context.router.push(const MakeReservationDetailRoute()),
            child: Text(
              '予約',
              style: const TextTheme().bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
