import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../notifier/reserve_table_notifier.dart';

@RoutePage()
class MakeReservationDetailPage extends HookConsumerWidget {
  const MakeReservationDetailPage(
      {super.key, required this.isAdditionalReservation});

  final bool isAdditionalReservation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(yuzucchi): 認証を追加
    final dateAndTimes = [Params(DateTime.now(), '1講')];

    final reserveTitleController = useState(TextEditingController());

    final reserveTable = ref.watch(reserveTableForReserveProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('予約詳細'),
        centerTitle: true,
      ),
      body: Form(
        child: Column(
          children: [
            Row(
              children: [
                const Text('予約時間: '),
                ...reserveTable.table.entries
                    .where((table) => table.value.isTapped)
                    .map((table) => Text(
                        '${table.key.weekDay.value} ${table.key.time.value}  '))
              ],
            ),
            TextFormField(
              controller: reserveTitleController.value,
              decoration: const InputDecoration(
                labelText: '予約名',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: '予約者名',
              ),
            ),
            ElevatedButton(
              child: const Text('予約確認'),
              onPressed: () =>
                  context.router.push(const ConfirmReservationRoute()),
            ),
          ],
        ),
      ),
    );
  }
}

class Params {
  Params(this.date, this.time);

  final DateTime date;
  final String time;
}
