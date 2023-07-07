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
      createdAt: _$JsonConverterFromJson<Timestamp, Timestamp>(
          json['created_at'], const TimestampConverter().fromJson),
      updatedAt: _$JsonConverterFromJson<Timestamp, Timestamp>(
          json['updated_at'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$$_ReservationModelToJson(_$_ReservationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': const TimestampConverter().toJson(instance.date),
      'time': instance.time,
      'reserved_member':
          const ReservedMemberConverter().toJson(instance.reservedMember),
      'created_at': _$JsonConverterToJson<Timestamp, Timestamp>(
          instance.createdAt, const TimestampConverter().toJson),
      'updated_at': _$JsonConverterToJson<Timestamp, Timestamp>(
          instance.updatedAt, const TimestampConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
