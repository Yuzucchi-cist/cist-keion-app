import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../widgets/reserve_table_widget.dart';

@RoutePage()
class ConfirmReservationPage extends HookConsumerWidget {
  const ConfirmReservationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(yuzucchi): 認証を追加
    final reservation = InputtedReservation(
      startDateOfWeek: DateTime(2023, 06, 04),
      dateAndTime: [
        ReservationDateAndTime(date: DateTime(2023, 06, 10), time: '1講')
      ],
      title: 'タイトル',
      reserveMemberName: 'ゆず',
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('確認'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FittedBox(
                child: ReserveTableWidget(
                    startDateOfWeek: reservation.startDateOfWeek),
              ),
            ),
            TextButton(
              onPressed: () =>
                  context.router.push(const ReservationCompleteRoute()),
              child: Text(
                '予約確定',
                style: const TextTheme().bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputtedReservation {
  InputtedReservation({
    required this.startDateOfWeek,
    required this.dateAndTime,
    required this.title,
    required this.reserveMemberName,
  });

  final DateTime startDateOfWeek;
  final List<ReservationDateAndTime> dateAndTime;
  final String title;
  final String reserveMemberName;
}

class ReservationDateAndTime {
  ReservationDateAndTime({required this.date, required this.time});

  final DateTime date;
  final String time;
}
