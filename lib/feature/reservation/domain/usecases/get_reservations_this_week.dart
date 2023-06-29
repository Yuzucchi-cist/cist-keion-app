import 'package:clock/clock.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class GetReservationsThisWeek implements UseCase<List<Reservation>, NoParams> {
  GetReservationsThisWeek({required this.reservationRepository});

  final ReservationRepository reservationRepository;

  @override
  Future<Either<Failure, List<Reservation>>> call(NoParams params) async {
    final today = clock.now();
    final startDateOfWeek = today.subtract(Duration(days: today.weekday));
    final endDateOfWeek =
        startDateOfWeek.add(const Duration(days: DateTime.daysPerWeek));
    return reservationRepository.getReservationsBetween(
        startDateOfWeek, endDateOfWeek);
  }
}
