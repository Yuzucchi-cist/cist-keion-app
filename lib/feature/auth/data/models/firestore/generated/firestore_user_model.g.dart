// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../firestore_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FirestoreUserModel _$$_FirestoreUserModelFromJson(
        Map<String, dynamic> json) =>
    _$_FirestoreUserModel(
      id: json['id'] as String,
      studentNumber: json['student_number'] as String,
      name: json['name'] as String,
      instituteGrade:
          $enumDecode(_$InstituteGradeModelEnumMap, json['institute_grade']),
      userState: $enumDecode(_$UserStateModelEnumMap, json['user_state']),
      belongings: const BelongingModelListConverter()
          .fromJson(json['belongings'] as List),
      isAdmin: json['is_admin'] as bool? ?? false,
    );

Map<String, dynamic> _$$_FirestoreUserModelToJson(
        _$_FirestoreUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'student_number': instance.studentNumber,
      'name': instance.name,
      'institute_grade': _$InstituteGradeModelEnumMap[instance.instituteGrade]!,
      'user_state': _$UserStateModelEnumMap[instance.userState]!,
      'belongings':
          const BelongingModelListConverter().toJson(instance.belongings),
      'is_admin': instance.isAdmin,
    };

const _$InstituteGradeModelEnumMap = {
  InstituteGradeModel.first: 'first',
  InstituteGradeModel.second: 'second',
  InstituteGradeModel.third: 'third',
  InstituteGradeModel.forth: 'forth',
  InstituteGradeModel.other: 'other',
};

const _$UserStateModelEnumMap = {
  UserStateModel.active: 'active',
  UserStateModel.sleep: 'sleep',
  UserStateModel.quited: 'quited',
};
