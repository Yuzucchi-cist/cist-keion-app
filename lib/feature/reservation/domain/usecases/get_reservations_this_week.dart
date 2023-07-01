import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class GetReservationsThisWeek implements UseCase<List<Reservation>, NoParams> {
  GetReservationsThisWeek({required this.reservationRepository});

  final ReservationRepository reservationRepository;

  @override
  Future<Either<Failure, List<Reservation>>> call(NoParams params) async {
    final startDateOfWeek = getStartDateOfThisWeek();
    final endDateOfWeek =
        startDateOfWeek.add(const Duration(days: DateTime.daysPerWeek));
    return reservationRepository.getReservationsBetween(
        startDateOfWeek, endDateOfWeek);
  }
}
