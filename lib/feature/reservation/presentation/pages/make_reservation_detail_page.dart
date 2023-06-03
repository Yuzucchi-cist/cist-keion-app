import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class MakeReservationDetailPage extends HookConsumerWidget {
  const MakeReservationDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(yuzucchi): 認証を追加
    final dateAndTimes = [Params(DateTime.now(), '1講')];

    final reserveTitleController = useState(TextEditingController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('予約詳細'),
        centerTitle: true,
      ),
      body: Form(
        child: Column(
          children: [
            Row(
              children: [const Text('予約時間: ')]
                  .followedBy(dateAndTimes
                      .map((param) => Text('${param.date} ${param.time}')))
                  .toList(),
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
              onPressed: () {},
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
