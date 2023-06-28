// ignore_for_file: sort_unnamed_constructors_first

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/values/institute_time.dart';
import 'reserve_table_cell.dart';
import 'week_day.dart';

part 'generated/reserve_table.freezed.dart';

@freezed
class ReserveTable with _$ReserveTable {
  const ReserveTable._();

  const factory ReserveTable({
    required Map<({WeekDay weekDay, InstituteTime time}), ReserveTableCell>
        table,
    required DateTime startDateOfWeek,
  }) = _ReserveTable;

  Map<InstituteTime, Map<WeekDay, ReserveTableCell>> get tableMap {
    final returnValue = <InstituteTime, Map<WeekDay, ReserveTableCell>>{};
    for (final e in table.entries) {
      if (returnValue.containsKey(e.key.time)) {
        returnValue[e.key.time]?.addAll({e.key.weekDay: e.value});
      } else {
        returnValue.addAll({
          e.key.time: {e.key.weekDay: e.value}
        });
      }
    }
    return returnValue;
  }

  DateTime get endDateOfWeek =>
      startDateOfWeek.add(const Duration(days: DateTime.daysPerWeek));
}
