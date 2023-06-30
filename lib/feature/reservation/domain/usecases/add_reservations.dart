import 'package:clock/clock.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';
import '../values/institute_time.dart';
import '../values/reserved_member.dart';

class AddReservations implements UseCase<void, List<AddReservationsParam>> {
  AddReservations({required this.reservationRepository});

  final ReservationRepository reservationRepository;

  @override
  Future<Either<Failure, void>> call(List<AddReservationsParam> params) async {
    final endDateOfNextWeek = getStartDateOfThisWeek()
        .add(const Duration(days: DateTime.daysPerWeek * 2));

    final reservations = params
        .map((param) => Reservation(
            id: '',
            title: param.title,
            date: param.date,
            reservedMember: ReservedMember(
                id: param.reservedMemberId, name: param.reservedMemberName),
            time: param.time))
        .toList();

    final reservationsSuitableWeek = reservations
        .where((reservation) =>
            reservation.date.isAfter(clock.now()) &&
            reservation.date.isBefore(endDateOfNextWeek))
        .toList();
    return reservationRepository.addReservations(reservationsSuitableWeek);
  }
}

class AddReservationsParam {
  AddReservationsParam(
      {required this.title,
      required this.date,
      required this.time,
      required this.reservedMemberId,
      required this.reservedMemberName});

  final String title;
  final DateTime date;
  final InstituteTime time;
  final String reservedMemberId;
  final String reservedMemberName;
}
