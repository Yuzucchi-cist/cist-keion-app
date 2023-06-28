import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../domain/values/institute_time.dart';
import '../states/reserve_table.dart';
import '../states/week_day.dart';

Widget reservationTable(BuildContext context,
    {required ReserveTable reserveTable,
    void Function(WeekDay weekDay, InstituteTime time)? onTap}) {
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
              return DataCell(
                Container(
                  width: MediaQuery.of(context).size.width / 8,
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  color: eCell.value.isTapped ? Colors.red : null,
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
                onTap: onTap != null ? () => onTap(eCell.key, eRow.key) : null,
              );
            }).toList();
            return DataRow(cells: [rowLabel, ...data]);
          }).toList(),
        ),
      )
    ],
  );
}
