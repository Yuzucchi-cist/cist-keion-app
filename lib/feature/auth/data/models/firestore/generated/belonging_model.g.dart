// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../belonging_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BelongingModel _$$_BelongingModelFromJson(Map<String, dynamic> json) =>
    _$_BelongingModel(
      id: json['id'] as String,
      type: $enumDecode(_$BelongingTypeEnumMap, json['type']),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_BelongingModelToJson(_$_BelongingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$BelongingTypeEnumMap[instance.type]!,
      'name': instance.name,
    };

const _$BelongingTypeEnumMap = {
  BelongingType.band: 'band',
  BelongingType.unexpected: 'unexpected',
};
