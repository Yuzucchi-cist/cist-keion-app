import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../widgets/show_confirm_dialog.dart';

@RoutePage()
class CancelReservationPage extends HookConsumerWidget {
  const CancelReservationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservations = <_Reservation>[
      _Reservation('id1', 'タイトル', DateTime(2023, 06, 05), '1講'),
      _Reservation('id2', 'タイトル2', DateTime(2023, 06, 02), '3講'),
      _Reservation('id3', 'タイトル3', DateTime(2023, 06, 02), '2講'),
    ];

    reservations.sort((r1, r2) {
      final result = r1.date.compareTo(r2.date);
      return result != 0 ? result : r1.time.compareTo(r2.time);
    });

    final isCheckedIds = useState<Map<String, bool>>({});

    return Scaffold(
      appBar: AppBar(
        title: const Text('確認'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Column(
            children: reservations
                .map((reservation) => ListTile(
                      title: Text(reservation.params),
                      leading: Checkbox(
                        value: isCheckedIds.value[reservation.id] ?? false,
                        onChanged: (value) {
                          final isCheckedIdsTmp = {...isCheckedIds.value};
                          isCheckedIdsTmp[reservation.id] = value ?? false;
                          isCheckedIds.value = isCheckedIdsTmp;
                        },
                      ),
                    ))
                .toList(),
          ),
          ElevatedButton(
            child: const Text('予約をキャンセル'),
            onPressed: () => showConfirmDialog(
              context: context,
              titleText: '予約キャンセル確認',
              contentText: '予約キャンセルしますか？',
              actions: [
                (context) => ElevatedButton(
                      child: const Text('NO'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                (context) => ElevatedButton(
                      child: const Text('OK'),
                      onPressed: () => showConfirmDialog(
                          context: context,
                          titleText: '予約キャンセル確認',
                          contentText: 'ほんとうに予約キャンセルしますか？',
                          actions: [
                            (context) => ElevatedButton(
                                  child: const Text('NO'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                ),
                            (context) => ElevatedButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();

                                    showConfirmDialog(
                                      context: context,
                                      titleText: 'キャンセル完了',
                                      contentText: '予約をキャンセルしました。',
                                      actions: [
                                        (context) => ElevatedButton(
                                              child: const Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                context.router.push(
                                                    const ChooseReserveTableRoute());
                                              },
                                            )
                                      ],
                                    );
                                  },
                                ),
                          ]),
                    ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Reservation {
  _Reservation(this.id, this.title, this.date, this.time);

  final String id;
  final String title;
  final DateTime date;
  final String time;

  String get params => '$date $time $title';
}
