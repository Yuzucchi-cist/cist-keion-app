import 'package:clock/clock.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../domain/repository/reservation_repository.dart';
import '../../value/institute_time.dart';

class DeleteReservations extends UseCase<Unit, DeleteReservationsParams> {
  DeleteReservations({required this.reservationRepository});

  final ReservationRepository reservationRepository;

  @override
  Future<Either<Failure, Unit>> call(DeleteReservationsParams params) {
    final nowTime = clock.now();
    final endDateOfWeek = getStartDateOfThisWeek()
        .add(const Duration(days: DateTime.daysPerWeek * 2));
    final suitableReservationIds = params.reservationParams
        .where((param) {
          final isSuitableDate =
              param.date.isAfter(nowTime) && param.date.isBefore(endDateOfWeek);
          final isSuitableMember = param.reservedMemberId == params.memberId;
          return isSuitableDate && isSuitableMember;
        })
        .map((param) => param.reservationId)
        .toList();

    return reservationRepository.deleteReservations(suitableReservationIds);
  }
}

class DeleteReservationsParams {
  DeleteReservationsParams(
      {required this.memberId, required this.reservationParams});

  final String memberId;
  final List<ReservationParams> reservationParams;
}

class ReservationParams {
  ReservationParams({
    required this.reservationId,
    required this.title,
    required this.date,
    required this.time,
    required this.reservedMemberId,
  });

  final String reservationId;
  final String title;
  final DateTime date;
  final InstituteTime time;
  final String reservedMemberId;
}
