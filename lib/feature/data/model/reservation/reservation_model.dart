// ignore_for_file: sort_unnamed_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'reserved_member_model.dart';

part 'generated/reservation_model.freezed.dart';
part 'generated/reservation_model.g.dart';

const firestoreTimestampFieldName = ['date', 'created_at', 'updated_at'];

@freezed
class ReservationModel with _$ReservationModel {
  const ReservationModel._();
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ReservationModel({
    required String id,
    required String title,
    @TimestampConverter() required Timestamp date,
    required String time,
    @ReservedMemberConverter() required ReservedMemberModel reservedMember,
    @TimestampConverter() required Timestamp createdAt,
    @TimestampConverter() required Timestamp updatedAt,
  }) = _ReservationModel;

  factory ReservationModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationModelFromJson(json);

  factory ReservationModel.fromFirestoreJson(
      String id, Map<String, dynamic> json) {
    final modelJson = {'id': id, ...json};
    return ReservationModel.fromJson(modelJson);
  }

  Map<String, dynamic> get toFirestoreJson {
    return toJson()..remove('id');
  }
}

class TimestampConverter implements JsonConverter<Timestamp, Timestamp> {
  const TimestampConverter();

  @override
  Timestamp fromJson(Timestamp json) {
    return json;
  }

  @override
  Timestamp toJson(Timestamp timestamp) {
    return timestamp;
  }
}

class ReservedMemberConverter
    implements JsonConverter<ReservedMemberModel, Map<String, dynamic>> {
  const ReservedMemberConverter();
  @override
  ReservedMemberModel fromJson(Map<String, dynamic> json) {
    return ReservedMemberModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(ReservedMemberModel object) {
    return object.toJson();
  }
}
