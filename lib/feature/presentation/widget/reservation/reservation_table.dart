import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/value/institute_time.dart';
import '../../provider/notifier/reservation/reserve_table_notifier.dart';
import '../../provider/state/reservation/reserve_table.dart';
import '../../provider/values/week_day.dart';

Widget reservationTable(BuildContext context, WidgetRef ref,
    {required AsyncNotifierProvider<ReserveTableNotifier, ReserveTable>
        reserveTableProvider,
    void Function(WeekDay weekDay, InstituteTime time)? onTap}) {
  return ref.watch(reserveTableProvider).when(
        data: (reserveTable) =>
            _convertReserveTableToWidget(context, reserveTable, onTap),
        error: (error, stackTrace) => Text('$error'),
        loading: () {
          // show loading
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
}

Widget _convertReserveTableToWidget(
    BuildContext context,
    ReserveTable reserveTable,
    void Function(WeekDay weekDay, InstituteTime time)? onTap) {
  final startDateOfWeek = reserveTable.startDateOfWeek;
  final endDateOfWeek = reserveTable.endDateOfWeek;
  return Column(
    children: [
      Text('$startDateOfWeek~$endDateOfWeekの予約'),
      Expanded(
        child: Center(
          child: DataTable(
            columnSpacing: 0,
            horizontalMargin: 0,
            decoration: BoxDecoration(border: Border.all()),
            columns: [
              DataColumn(
                  label: Expanded(
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(border: Border.all()),
                    child: const Text('')),
              )),
              ...reserveTable.tableMap.values.first.keys
                  .map((weekDay) => DataColumn(
                          label: Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(border: Border.all()),
                            child: Text(weekDay.value)),
                      )))
            ],
            rows: reserveTable.tableMap.entries.map<DataRow>((eRow) {
              final rowLabel = DataCell(SizedBox(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(border: Border.all()),
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
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: isTapped ? Colors.red : null,
                    ),
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
        ),
      )
    ],
  );
}
