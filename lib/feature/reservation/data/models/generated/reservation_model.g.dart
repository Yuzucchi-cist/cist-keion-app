// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../reservation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReservationModel _$$_ReservationModelFromJson(Map<String, dynamic> json) =>
    _$_ReservationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      date: const TimestampConverter().fromJson(json['date'] as Timestamp),
      time: json['time'] as String,
      reservedMember: const ReservedMemberConverter()
          .fromJson(json['reserved_member'] as Map<String, dynamic>),
      createdAt:
          const TimestampConverter().fromJson(json['created_at'] as Timestamp),
      updatedAt:
          const TimestampConverter().fromJson(json['updated_at'] as Timestamp),
    );

Map<String, dynamic> _$$_ReservationModelToJson(_$_ReservationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': const TimestampConverter().toJson(instance.date),
      'time': instance.time,
      'reserved_member':
          const ReservedMemberConverter().toJson(instance.reservedMember),
      'created_at': const TimestampConverter().toJson(instance.createdAt),
      'updated_at': const TimestampConverter().toJson(instance.updatedAt),
    };
