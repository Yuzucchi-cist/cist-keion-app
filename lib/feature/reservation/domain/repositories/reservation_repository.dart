import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../entities/reservation.dart';

abstract class ReservationRepository {
  Future<Either<Failure, List<Reservation>>> getReservationsBetween(
      DateTime startDate, DateTime endDate);

  Future<Either<Failure, Unit>> addReservations(List<Reservation> reservations);
}
