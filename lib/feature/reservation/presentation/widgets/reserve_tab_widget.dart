import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    final endDateOfWeek =
        startDateOfWeek.add(const Duration(days: DateTime.daysPerWeek));

    final datesOfWeek = List<DateTime>.generate(DateTime.daysPerWeek,
        (diffDays) => startDateOfWeek.add(Duration(days: diffDays)));
    return Center(
      child: Column(
        children: [
          Text('$startDateOfWeek~$endDateOfWeekの予約'),
          Expanded(
            child: FittedBox(
              child: DataTable(
                columns: datesOfWeek
                    .map((date) =>
                        DataColumn(label: Text(_WeekDay.fromDate(date).value)))
                    .toList(),
                rows: List.filled(7,
                    DataRow(cells: List.filled(7, const DataCell(Text(''))))),
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
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

enum _WeekDay {
  sun('日'),
  mon('月'),
  tue('火'),
  wed('水'),
  thu('木'),
  fri('金'),
  str('土');

  final String value;
  // ignore: sort_constructors_first
  const _WeekDay(this.value);
  // ignore: sort_constructors_first
  factory _WeekDay.fromDate(DateTime date) {
    return _WeekDay.values[(date.weekday % DateTime.daysPerWeek)];
  }

  DateTime get date {
    final today = DateTime.now();
    return today.subtract(Duration(days: (today.weekday % 7) - index));
  }
}
