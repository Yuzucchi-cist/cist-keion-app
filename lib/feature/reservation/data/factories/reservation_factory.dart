import 'package:clock/clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/factories/data_factory.dart';
import '../../domain/entities/reservation.dart';
import '../models/reservation_model.dart';
import 'institute_time_factory.dart';
import 'reserved_member_factory.dart';

class ReservationFactory
    implements DataFactory<Reservation, ReservationModel, ReservationParams> {
  ReservationFactory(
      {required this.reservedMemberFactory,
      required this.instituteTimeFactory});

  final ReservedMemberFactory reservedMemberFactory;
  final InstituteTimeFactory instituteTimeFactory;

  @override
  ReservationModel convertToModel(Reservation entity) {
    return ReservationModel(
        id: entity.id,
        title: entity.title,
        date: Timestamp.fromDate(entity.date.copyWith(hour: 12)),
        time: instituteTimeFactory.convertToModel(entity.time),
        reservedMember:
            reservedMemberFactory.convertToModel(entity.reservedMember),
        createdAt: entity.createdAt != null
            ? Timestamp.fromDate(entity.createdAt!)
            : Timestamp.fromDate(clock.now()),
        updatedAt: entity.updatedAt != null
            ? Timestamp.fromDate(entity.updatedAt!)
            : Timestamp.fromDate(clock.now()));
  }

  @override
  Reservation create(ReservationParams params) {
    return Reservation(
        id: params.id,
        title: params.title,
        date: params.date,
        reservedMember:
            reservedMemberFactory.create(params.reservedMemberParams),
        time: instituteTimeFactory.create(params.time),
        createdAt: params.createdAt,
        updatedAt: params.updatedAt);
  }

  @override
  Reservation createFromModel(ReservationModel model) {
    return Reservation(
        id: model.id,
        title: model.title,
        date: model.date.toDate().copyWith(hour: 0),
        reservedMember:
            reservedMemberFactory.createFromModel(model.reservedMember),
        time: instituteTimeFactory.createFromModel(model.time),
        createdAt: model.createdAt.toDate(),
        updatedAt: model.updatedAt.toDate());
  }
}

class ReservationParams {
  ReservationParams({
    required this.id,
    required this.title,
    required this.date,
    required this.reservedMemberParams,
    required this.time,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String title;
  final DateTime date;
  final ReservedMemberParams reservedMemberParams;
  final String time;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
