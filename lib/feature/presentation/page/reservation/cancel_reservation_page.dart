import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../../provider/notifier/reservation/delete_param_notifier.dart';
import '../../provider/notifier/reservation/reserve_table_notifier.dart';
import '../../widget/show_confirm_dialog.dart';

@RoutePage()
class CancelReservationPage extends HookConsumerWidget {
  const CancelReservationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservations = ref.watch(deleteParamProvider);

    reservations.sort((r1, r2) {
      final result = r1.date.compareTo(r2.date);
      return result != 0 ? result : r1.time.index - r2.time.index;
    });

    final isChecked = useState(
        Map.fromEntries(reservations.map((rsv) => MapEntry(rsv.id, false))));

    return Scaffold(
      appBar: AppBar(
        title: const Text('確認'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: reservations
                    .map((memberReservation) => ListTile(
                          title: Text(memberReservation.params),
                          leading: Checkbox(
                            value: isChecked.value[memberReservation.id],
                            onChanged: (value) {
                              final newValue = {...isChecked.value};
                              newValue[memberReservation.id] = value!;
                              isChecked.value = newValue;
                            },
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          ElevatedButton(
            child: const Text('予約をキャンセル'),
            onPressed: () {
              final checkedReservations = reservations
                  .where((rsv) => isChecked.value[rsv.id] ?? false)
                  .toList();
              showConfirmDialog(
                context: context,
                titleText: '予約キャンセル確認',
                contentText: '予約キャンセルしますか？\n'
                    '${checkedReservations.map((rsv) => '${rsv.params}\n').join()}',
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
                                      ref
                                          .read(deleteParamProvider.notifier)
                                          .delete(checkedReservations)
                                          .then((_) {
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
                                                    updateReservationTable(ref)
                                                        .then((value) {
                                                      Navigator.of(context)
                                                          .pop();
                                                      context.router.push(
                                                          const ChooseReserveTableRoute());
                                                    });
                                                  },
                                                )
                                          ],
                                        );
                                      });
                                    },
                                  ),
                            ]),
                      ),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  Future<void> updateReservationTable(WidgetRef ref) async {
    await ref
        .read(reserveTableForReserveInThisWeekProvider.notifier)
        .updateReservationTable();
    await ref
        .read(reserveTableForReserveInNextWeekProvider.notifier)
        .updateReservationTable();
  }
}
