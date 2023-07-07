// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../suggestion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SuggestionModel _$$_SuggestionModelFromJson(Map<String, dynamic> json) =>
    _$_SuggestionModel(
      description: json['description'] as String,
      category: json['category'] as String,
      createdAt: _$JsonConverterFromJson<Timestamp, Timestamp>(
          json['created_at'], const TimestampConverter().fromJson),
    );

Map<String, dynamic> _$$_SuggestionModelToJson(_$_SuggestionModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'category': instance.category,
      'created_at': _$JsonConverterToJson<Timestamp, Timestamp>(
          instance.createdAt, const TimestampConverter().toJson),
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
