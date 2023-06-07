import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/utils/date_time_utils.dart';
import '../states/institute_time.dart';
import '../states/reserve_table.dart';
import '../states/reserve_table_cell.dart';
import '../states/week_day.dart';

final reserveTableProvider =
    StateNotifierProvider<ReserveTableNotifier, ReserveTable>(
        (ref) => ReserveTableNotifier(ReserveTable(
              table: Map.fromIterables(
                  WeekDay.values
                      .map((day) => InstituteTime.values
                          .map((time) => (weekDay: day, time: time)))
                      .expand((values) => values)
                      .toList(),
                  List.filled(
                      WeekDay.values.length * InstituteTime.values.length,
                      const ReserveTableCell(title: 'ガールズばんどがしたい！'))),
              startDateOfWeek: getStartDateOfThisWeek(),
            )));

final reserveTableForReserveProvider =
    StateNotifierProvider<ReserveTableNotifier, ReserveTable>(
        (ref) => ReserveTableNotifier(ReserveTable(
              table: Map.fromIterables(
                  WeekDay.values
                      .map((day) => InstituteTime.values
                          .map((time) => (weekDay: day, time: time)))
                      .expand((values) => values)
                      .toList(),
                  List.filled(
                      WeekDay.values.length * InstituteTime.values.length,
                      const ReserveTableCell(title: 'ガールズばんどがしたい！'))),
              startDateOfWeek: getStartDateOfThisWeek()
                  .add(Duration(days: DateTime.daysPerWeek)),
            )));

class ReserveTableNotifier extends StateNotifier<ReserveTable> {
  ReserveTableNotifier(super.state);

  void onTapped(WeekDay weekDay, InstituteTime time) {
    final clonedTable = {...state.table};
    final cell = state.table[(weekDay: weekDay, time: time)]!;
    clonedTable[(weekDay: weekDay, time: time)] =
        cell.copyWith(isTapped: !cell.isTapped);
    state = state.copyWith(table: clonedTable);
  }

  void resetIsTapped() {
    state = state.copyWith(
        table: state.table.map(
            (key, value) => MapEntry(key, value.copyWith(isTapped: false))));
  }

  bool isChosen() {
    return state.table.values.map((cell) => cell.isTapped).contains(true);
  }
}
