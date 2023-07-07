// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../suggestion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SuggestionModel _$$_SuggestionModelFromJson(Map<String, dynamic> json) =>
    _$_SuggestionModel(
      description: json['description'] as String,
      category: json['category'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['created_at'] as Timestamp),
    );

Map<String, dynamic> _$$_SuggestionModelToJson(_$_SuggestionModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'category': instance.category,
      'created_at': const TimestampConverter().toJson(instance.createdAt),
    };
