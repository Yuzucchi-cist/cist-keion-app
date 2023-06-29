import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../notifier/reserve_table_notifier.dart';
import '../widgets/reservation_table.dart';
import '../widgets/show_confirm_dialog.dart';

@RoutePage()
class ConfirmReservationPage extends HookConsumerWidget {
  const ConfirmReservationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(yuzucchi): 認証を追加
    return Scaffold(
      appBar: AppBar(
        title: const Text('確認'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: reservationTable(context, ref,
                  reserveTableProvider: reserveTableForReserveProvider),
            ),
            TextButton(
              child: Text(
                '予約確定',
                style: const TextTheme().bodyLarge,
              ),
              onPressed: () => showConfirmDialog(
                context: context,
                titleText: '予約完了',
                contentText: '予約が完了しました。',
                actions: [
                  (context) => ElevatedButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          context.router.push(const ChooseReserveTableRoute());
                        },
                      )
                ],
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
