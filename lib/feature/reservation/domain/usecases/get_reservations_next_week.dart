import 'package:clock/clock.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class GetReservationsNextWeek implements UseCase<List<Reservation>, NoParams> {
  GetReservationsNextWeek({required this.reservationRepository});

  final ReservationRepository reservationRepository;
  @override
  Future<Either<Failure, List<Reservation>>> call(NoParams params) async {
    final today = clock.now();
    final startDateOfNextWeek = today
        .subtract(Duration(days: today.weekday))
        .add(const Duration(days: DateTime.daysPerWeek));
    final endDateOfNextWeek =
        startDateOfNextWeek.add(const Duration(days: DateTime.daysPerWeek));
    return reservationRepository.getReservationsBetween(
        startDateOfNextWeek, endDateOfNextWeek);
  }
}
