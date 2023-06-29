import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception/firestore_exception.dart';
import '../../../../core/error/failure/failure.dart';
import '../../../../core/error/failure/reservation/reservation_failure.dart';
import '../../../../core/error/failure/server/server_failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/reservation.dart';
import '../../domain/repositories/reservation_repository.dart';
import '../datasources/reservation_local_data_source.dart';
import '../datasources/reservation_remote_data_source.dart';
import '../factories/reservation_factory.dart';
import '../models/reservation_model.dart';

class ReservationRepositoryImpl implements ReservationRepository {
  ReservationRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo,
      required this.reservationFactory});

  final ReservationRemoteDataSource remoteDataSource;
  final ReservationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final ReservationFactory reservationFactory;

  @override
  Future<Either<Failure, List<Reservation>>> getReservationsBetween(
      DateTime startDate, DateTime endDate) async {
    try {
      late List<ReservationModel> models;
      if (await networkInfo.isConnected) {
        models = await remoteDataSource.getReservationsBetween(
            Timestamp.fromDate(startDate), Timestamp.fromDate(endDate));
        localDataSource.cacheReservations(models);
      } else {
        models = await localDataSource.getReservations();
      }
      final reservations = models
          .map((model) => reservationFactory.createFromModel(model))
          .toList();
      return Right(reservations);
    } on FirestoreException catch (e) {
      return Left(ReservationFailure.fromCode(e.code));
    }
  }

  @override
  Future<Either<Failure, Unit>> addReservations(
      List<Reservation> reservations) async {
    if (await networkInfo.isConnected) {
      try {
        remoteDataSource.addReservations(reservations
            .map(
                (reservation) => reservationFactory.convertToModel(reservation))
            .toList());
        return const Right(unit);
      } on FirestoreException catch (e) {
        return Left(ReservationFailure.fromCode(e.code));
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
