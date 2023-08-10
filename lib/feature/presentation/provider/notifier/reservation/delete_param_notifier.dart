import 'package:clock/clock.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/error/failure/reservation/reservation_failure.dart';
import '../../../../../core/error/failure/reservation/reservation_failure_state.dart';
import '../../../../../core/error/failure/server/server_failure.dart';
import '../../../../../core/provider_di.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../domain/usecase/reservation/delete_reservations.dart';
import '../../../../domain/usecase/reservation/get_reservations_next_week.dart';
import '../../../../domain/usecase/reservation/get_reservations_this_week.dart';
import '../../state/reservation/member_reservation.dart';
import '../auth/auth_notifier.dart';

final deleteParamProvider =
    StateNotifierProvider<DeleteParamNotifier, List<MemberReservation>>((ref) =>
        DeleteParamNotifier(
          deleteReservations: ref.watch(deleteReservationsProvider),
          getReservationsThisWeek: ref.watch(getReservationsThisWeekProvider),
          getReservationsNextWeek: ref.watch(getReservationsNextWeekProvider),
          memberId: ref.watch(authProvider).when(
              unAuthenticated: () => null,
              unVerified: (_) => null,
              authenticated: (member) => member.memberId),
        ));

class DeleteParamNotifier extends StateNotifier<List<MemberReservation>> {
  DeleteParamNotifier(
      {required this.deleteReservations,
      required this.getReservationsThisWeek,
      required this.getReservationsNextWeek,
      required this.memberId})
      : super([]);

  final DeleteReservations deleteReservations;
  final GetReservationsThisWeek getReservationsThisWeek;
  final GetReservationsNextWeek getReservationsNextWeek;
  final String? memberId;

  Future<void> update() async {
    final nowTime = clock.now();
    final reservationsThisWeek =
        (await getReservationsThisWeek(NoParams())).fold(
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
        throw Exception('Unexpected Error');
      },
      (r) => r.where((reservation) => reservation.date.isAfter(nowTime)),
    );
    final reservationsNextWeek =
        (await getReservationsNextWeek(NoParams())).fold(
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
        throw Exception('Unexpected Error');
      },
      (r) => r,
    );

    state = [...reservationsThisWeek!, ...reservationsNextWeek!]
        .where((reservation) => reservation.reservedMember.id == memberId)
        .map((reservation) => MemberReservation(reservation: reservation))
        .toList();
  }

  Future<void> delete(List<MemberReservation> reservations) async {
    final reservationParams = reservations
        .map((reservation) => ReservationParams(
            reservationId: reservation.id,
            title: reservation.title,
            date: reservation.date,
            time: reservation.time,
            reservedMemberId: reservation.reservedMemberId))
        .toList();
    final params = DeleteReservationsParams(
        memberId: memberId!, reservationParams: reservationParams);
    await deleteReservations(params);
    await update();
  }
}
