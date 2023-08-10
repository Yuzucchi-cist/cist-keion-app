import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/error/failure/reservation/reservation_failure.dart';
import '../../../../../core/error/failure/reservation/reservation_failure_state.dart';
import '../../../../../core/error/failure/server/server_failure.dart';
import '../../../../../core/provider_di.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/date_time_utils.dart';
import '../../../../domain/entity/reservation/reservation.dart';
import '../../../../domain/usecase/reservation/add_reservations.dart';
import '../../../../domain/value/institute_time.dart';
import '../../state/reservation/reserve_table.dart';
import '../../state/reservation/week_day.dart';

final reserveTableForDisplayInThisWeekProvider =
    StateNotifierProvider<ReserveTableNotifier, ReserveTable>((ref) {
  final notifier = ReserveTableNotifier(
      getReservations: ref.watch(getReservationsThisWeekProvider),
      addReservations: ref.watch(addReservationsProvider),
      startDateOfWeek: getStartDateOfThisWeek());
  return notifier;
});

final reserveTableForDisplayInNextWeekProvider =
    StateNotifierProvider<ReserveTableNotifier, ReserveTable>((ref) {
  final notifier = ReserveTableNotifier(
      getReservations: ref.watch(getReservationsNextWeekProvider),
      addReservations: ref.watch(addReservationsProvider),
      startDateOfWeek: getStartDateOfThisWeek()
          .add(const Duration(days: DateTime.daysPerWeek)));
  return notifier;
});

final reserveTableForReserveInThisWeekProvider =
    StateNotifierProvider<ReserveTableNotifier, ReserveTable>((ref) {
  final notifier = ReserveTableNotifier(
      getReservations: ref.watch(getReservationsThisWeekProvider),
      addReservations: ref.watch(addReservationsProvider),
      startDateOfWeek: getStartDateOfThisWeek());
  return notifier;
});

final reserveTableForReserveInNextWeekProvider =
    StateNotifierProvider<ReserveTableNotifier, ReserveTable>((ref) {
  final notifier = ReserveTableNotifier(
      getReservations: ref.watch(getReservationsNextWeekProvider),
      addReservations: ref.watch(addReservationsProvider),
      startDateOfWeek: getStartDateOfThisWeek()
          .add(const Duration(days: DateTime.daysPerWeek)));
  return notifier;
});

class ReserveTableNotifier extends StateNotifier<ReserveTable> {
  ReserveTableNotifier({
    required this.getReservations,
    required this.addReservations,
    required this.startDateOfWeek,
  }) : super(ReserveTable.init(startDateOfWeek));

  final UseCase<List<Reservation>, NoParams> getReservations;
  final AddReservations addReservations;
  final DateTime startDateOfWeek;

  Future<void> initialize() async {
    update();
  }

  Future<void> update() async {
    final result = await getReservations(NoParams());
    result.fold(
      (l) {
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
      },
      (reservations) {
        state = ReserveTable.fromReservationList(reservations, startDateOfWeek,
            oldTable: state);
      },
    );
  }

  Future<void> add() async {
    final params = state.table.entries
        .where((cell) => cell.value.id == null && cell.value.isTapped)
        .map((cell) => AddReservationsParam(
            title: cell.value.title,
            date: cell.key.weekDay.date(startDateOfWeek),
            time: cell.key.time,
            reservedMemberId: cell.value.reserveMemberId!,
            reservedMemberName: cell.value.reserveMemberName!))
        .toList();
    final result = await addReservations(params);
    await result.fold((l) {
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
    }, (r) async => update());
  }

  void onTapped(WeekDay weekDay, InstituteTime time) {
    final clonedTable = {...state.table};
    final cell = state.table[(weekDay: weekDay, time: time)]!;
    if (cell.id == null) {
      final isTapped = cell.isTapped;
      clonedTable[(weekDay: weekDay, time: time)] =
          cell.copyWith(isTapped: !isTapped);
      state = state.copyWith(table: clonedTable);
    }
  }

  void resetIsTapped() {
    state = state.copyWith(
        table: state.table.map(
            (key, value) => MapEntry(key, value.copyWith(isTapped: false))));
  }

  bool isChosen() {
    return state.table.values.map((cell) => cell.isTapped).contains(true);
  }

  void setDetail(
      String title, String reservedMemberId, String reservedMemberName) {
    state = state.copyWith(table: state.table.map((key, value) {
      return value.isTapped
          ? MapEntry(
              key,
              value.copyWith(
                  title: title,
                  reserveMemberId: reservedMemberId,
                  reserveMemberName: reservedMemberName))
          : MapEntry(key, value);
    }));
  }
}
