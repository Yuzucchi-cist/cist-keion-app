import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/values/institute_time.dart';
import '../notifier/reserve_table_notifier.dart';
import '../states/reserve_table.dart';
import '../states/week_day.dart';

Widget reservationTable(BuildContext context, WidgetRef ref,
    {required StateNotifierProvider<ReserveTableNotifier, ReserveTable>
        reserveTableProvider,
    void Function(WeekDay weekDay, InstituteTime time)? onTap}) {
  final reserveTable = ref.watch(reserveTableProvider);
  final startDateOfWeek = reserveTable.startDateOfWeek;
  final endDateOfWeek = reserveTable.endDateOfWeek;
  return Column(
    children: [
      Text('$startDateOfWeek~$endDateOfWeekの予約'),
      Expanded(
        child: DataTable(
          columnSpacing: 0,
          horizontalMargin: 0,
          columns: [
            const DataColumn(label: Center(child: Text(''))),
            ...reserveTable.tableMap.values.first.keys.map((weekDay) =>
                DataColumn(label: Center(child: Text(weekDay.value))))
          ],
          rows: reserveTable.tableMap.entries.map<DataRow>((eRow) {
            final rowLabel = DataCell(SizedBox(
              child: Center(
                child: Text(
                  eRow.key.value,
                  softWrap: false,
                ),
              ),
            ));
            final data = eRow.value.entries.map((eCell) {
              final isTapped = eCell.value.isTapped;
              return DataCell(
                Container(
                  width: MediaQuery.of(context).size.width / 8,
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  color: isTapped ? Colors.red : null,
                  child: Align(
                    child: AutoSizeText(
                      eCell.value.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      minFontSize: 8,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                onTap: eCell.value.id == null && onTap != null
                    ? () => onTap(eCell.key, eRow.key)
                    : null,
              );
            }).toList();
            return DataRow(cells: [rowLabel, ...data]);
          }).toList(),
        ),
      )
    ],
  );
}
