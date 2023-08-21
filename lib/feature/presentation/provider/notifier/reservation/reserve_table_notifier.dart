import 'dart:async';

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
import '../../values/week_day.dart';

final reserveTableForDisplayInThisWeekProvider =
    AsyncNotifierProvider<ReserveTableNotifier, ReserveTable>(
        () => ReserveTableNotifier(isThisWeek: true));

final reserveTableForDisplayInNextWeekProvider =
    AsyncNotifierProvider<ReserveTableNotifier, ReserveTable>(() {
  final notifier = ReserveTableNotifier(isThisWeek: false);
  return notifier;
});

final reserveTableForReserveInThisWeekProvider =
    AsyncNotifierProvider<ReserveTableNotifier, ReserveTable>(
        () => ReserveTableNotifier(isThisWeek: true));

final reserveTableForReserveInNextWeekProvider =
    AsyncNotifierProvider<ReserveTableNotifier, ReserveTable>(() {
  final notifier = ReserveTableNotifier(isThisWeek: false);
  return notifier;
});

class ReserveTableNotifier extends AsyncNotifier<ReserveTable> {
  ReserveTableNotifier({required bool isThisWeek})
      : getReservations = isThisWeek
            ? getReservationsThisWeekProvider
            : getReservationsNextWeekProvider,
        addReservations = addReservationsProvider,
        startDateOfWeek = isThisWeek
            ? getStartDateOfThisWeek()
            : getStartDateOfThisWeek()
                .add(const Duration(days: DateTime.daysPerWeek));

  final Provider<UseCase<List<Reservation>, NoParams>> getReservations;
  final Provider<AddReservations> addReservations;
  final DateTime startDateOfWeek;

  @override
  FutureOr<ReserveTable> build() => getReserveTable();

  Future<ReserveTable> getReserveTable() async {
    final result = await ref.read(getReservations)(NoParams());
    return result.fold(
      (failure) {
        if (failure is ServerFailure) {
          throw Exception(failure);
        } else if (failure is ReservationFailure) {
          switch (failure.state) {
            case ReservationFailureState.noData:
            case ReservationFailureState.cannotCached:
              return ReserveTable.init(startDateOfWeek);
            case ReservationFailureState.unexpected:
              throw Exception('Unexpected Error');
          }
        } else {
          throw Exception('Unexpected Error');
        }
      },
      (reservations) {
        return ReserveTable.fromReservationList(reservations, startDateOfWeek,
            oldTable: state.valueOrNull);
      },
    );
  }

  Future<void> updateReservationTable() async {
    final oldState = state;
    state = const AsyncLoading();
    final result = await ref.read(getReservations)(NoParams());
    result.fold(
      (failure) {
        if (failure is ServerFailure) {
          state = AsyncError(failure, StackTrace.current);
        } else if (failure is ReservationFailure) {
          switch (failure.state) {
            case ReservationFailureState.noData:
            case ReservationFailureState.cannotCached:
              state = oldState;
            case ReservationFailureState.unexpected:
              state = AsyncError('unexpected', StackTrace.current);
          }
        }
      },
      (reservations) {
        state = AsyncData(ReserveTable.fromReservationList(
            reservations, startDateOfWeek,
            oldTable: oldState.valueOrNull));
      },
    );
  }

  Future<void> add() async {
    final params = state.value?.table.entries
        .where((cell) => cell.value.id == null && cell.value.isTapped)
        .map((cell) => AddReservationsParam(
            title: cell.value.title,
            date: cell.key.weekDay.date(startDateOfWeek),
            time: cell.key.time,
            reservedMemberId: cell.value.reserveMemberId!,
            reservedMemberName: cell.value.reserveMemberName!))
        .toList();
    if (params == null) {
      throw Exception('何も登録されませんでhした');
    }
    final result = await ref.read(addReservations)(params);
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
    }, (r) async => updateReservationTable());
  }

  void onTapped(WeekDay weekDay, InstituteTime time) {
    final reserveTable = state.value;
    if (reserveTable != null) {
      final clonedTable = {...reserveTable.table};
      final cell = reserveTable.table[(weekDay: weekDay, time: time)];
      if (cell == null) {
        throw Exception('cell is null');
      }
      if (cell.id == null) {
        final isTapped = cell.isTapped;
        clonedTable[(weekDay: weekDay, time: time)] =
            cell.copyWith(isTapped: !isTapped);
        state = AsyncData(reserveTable.copyWith(table: clonedTable));
      }
    }
  }

  void resetIsTapped() {
    final reserveTable = state.value;
    if (reserveTable != null) {
      state = AsyncData(reserveTable.resetIsTapped());
    }
  }

  bool hasChosenCell() {
    return state.value?.table.values
            .map((cell) => cell.isTapped)
            .contains(true) ??
        false;
  }

  void setDetail(
      String title, String reservedMemberId, String reservedMemberName) {
    final oldState = state;
    final newValue =
        state.value?.setDetail(title, reservedMemberId, reservedMemberName);
    state = newValue == null ? oldState : AsyncData(newValue);
  }
}
