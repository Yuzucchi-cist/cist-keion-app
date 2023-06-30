import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../../../auth/presentation/notifier/auth_notifier.dart';
import '../notifier/reserve_table_notifier.dart';

@RoutePage()
class MakeReservationDetailPage extends HookConsumerWidget {
  MakeReservationDetailPage({super.key, required this.isAdditionalReservation});

  final _formKey = GlobalKey<FormState>();
  final bool isAdditionalReservation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reserveTitleController = useState(TextEditingController());
    final reserveTableProvider = isAdditionalReservation
        ? reserveTableInThisWeekProvider
        : reserveTableInNextWeekProvider;
    final reserveTable = ref.watch(reserveTableProvider);

    final member = ref.watch(authProvider).when(
        unAuthenticated: () => null,
        unVerified: (_) => null,
        authenticated: (member) => member);

    return Scaffold(
      appBar: AppBar(
        title: const Text('予約詳細'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
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
            Row(
              children: [
                const Text('予約者名: '),
                Text(member?.name ?? ''),
              ],
            ),
            ElevatedButton(
              child: const Text('予約確認'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final title = reserveTitleController.value.text;
                  ref
                      .read(reserveTableProvider.notifier)
                      .setDetail(title, member!.memberId, member.name);
                  context.router.push(ConfirmReservationRoute(
                      isAdditionalReservation: isAdditionalReservation));
                }
              },
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
