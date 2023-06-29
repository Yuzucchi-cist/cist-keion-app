// ignore_for_file: sort_unnamed_constructors_first

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/date_time_utils.dart';
import '../../domain/entities/reservation.dart';
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

  factory ReserveTable.init([DateTime? startDateOfWeek]) => ReserveTable(
      table: _initialMap,
      startDateOfWeek: startDateOfWeek ?? getStartDateOfThisWeek());

  factory ReserveTable.fromReservationList(
      List<Reservation> reservationList, DateTime startDateOfWeek,
      {ReserveTable? oldTable}) {
    final newTable = {...oldTable?.table ?? _initialMap};

    for (final reservation in reservationList) {
      newTable.update(
          (weekDay: WeekDay.fromDate(reservation.date), time: reservation.time),
          (value) =>
              value.copyWith(title: reservation.title, id: reservation.id));
    }
    return oldTable?.copyWith(table: newTable) ??
        ReserveTable(table: newTable, startDateOfWeek: startDateOfWeek);
  }

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
      startDateOfWeek.add(const Duration(days: DateTime.daysPerWeek - 1));
}

final _initialMap = Map.fromIterables(
    WeekDay.values
        .map((day) =>
            InstituteTime.values.map((time) => (weekDay: day, time: time)))
        .expand((values) => values)
        .toList(),
    List.filled(WeekDay.values.length * InstituteTime.values.length,
        const ReserveTableCell(title: '')));
