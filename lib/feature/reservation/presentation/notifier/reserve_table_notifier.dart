import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/error/failure/reservation/reservation_failure.dart';
import '../../../../core/error/failure/reservation/reservation_failure_state.dart';
import '../../../../core/error/failure/server/server_failure.dart';
import '../../../../core/provider_di.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../domain/entities/reservation.dart';
import '../../domain/values/institute_time.dart';
import '../states/reserve_table.dart';
import '../states/week_day.dart';

final reserveTableInThisWeekProvider =
    StateNotifierProvider<ReserveTableNotifier, ReserveTable>((ref) {
  final notifier = ReserveTableNotifier(
      getReservations: ref.watch(getReservationsThisWeekProvider),
      startDateOfWeek: getStartDateOfThisWeek());
  return notifier;
});

final reserveTableInNextWeekProvider =
    StateNotifierProvider<ReserveTableNotifier, ReserveTable>((ref) {
  final notifier = ReserveTableNotifier(
      getReservations: ref.watch(getReservationsNextWeekProvider),
      startDateOfWeek: getStartDateOfThisWeek()
          .add(const Duration(days: DateTime.daysPerWeek)));
  return notifier;
});

class ReserveTableNotifier extends StateNotifier<ReserveTable> {
  ReserveTableNotifier({
    required this.getReservations,
    required this.startDateOfWeek,
  }) : super(ReserveTable.init(startDateOfWeek));

  final UseCase<List<Reservation>, NoParams> getReservations;
  final DateTime startDateOfWeek;

  Future<void> update() async {
    final result = await getReservations(NoParams());
    result.fold((l) {
      if (l is ServerFailure) {
        throw Exception(l);
      } else if (l is ReservationFailure) {
        switch (l.state) {
          case ReservationFailureState.noData:
          case ReservationFailureState.cannotCached:
            return;
          case ReservationFailureState.unexpected:
            throw Exception('Unexpected Error');
        }
      }
    }, (reservations) {
      state = ReserveTable.fromReservationList(reservations, startDateOfWeek,
          oldTable: state);
    });
  }

  void onTapped(WeekDay weekDay, InstituteTime time) {
    final clonedTable = {...state.table};
    final cell = state.table[(weekDay: weekDay, time: time)]!;
    final isTapped = cell.isTapped;
    clonedTable[(weekDay: weekDay, time: time)] =
        cell.copyWith(isTapped: !isTapped);
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
