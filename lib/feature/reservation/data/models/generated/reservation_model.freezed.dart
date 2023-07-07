// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../reservation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReservationModel _$ReservationModelFromJson(Map<String, dynamic> json) {
  return _ReservationModel.fromJson(json);
}

/// @nodoc
mixin _$ReservationModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @TimestampConverter()
  Timestamp get date => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  @ReservedMemberConverter()
  ReservedMemberModel get reservedMember => throw _privateConstructorUsedError;
  @TimestampConverter()
  Timestamp get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  Timestamp get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReservationModelCopyWith<ReservationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationModelCopyWith<$Res> {
  factory $ReservationModelCopyWith(
          ReservationModel value, $Res Function(ReservationModel) then) =
      _$ReservationModelCopyWithImpl<$Res, ReservationModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      @TimestampConverter() Timestamp date,
      String time,
      @ReservedMemberConverter() ReservedMemberModel reservedMember,
      @TimestampConverter() Timestamp createdAt,
      @TimestampConverter() Timestamp updatedAt});

  $ReservedMemberModelCopyWith<$Res> get reservedMember;
}

/// @nodoc
class _$ReservationModelCopyWithImpl<$Res, $Val extends ReservationModel>
    implements $ReservationModelCopyWith<$Res> {
  _$ReservationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? date = null,
    Object? time = null,
    Object? reservedMember = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      reservedMember: null == reservedMember
          ? _value.reservedMember
          : reservedMember // ignore: cast_nullable_to_non_nullable
              as ReservedMemberModel,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ReservedMemberModelCopyWith<$Res> get reservedMember {
    return $ReservedMemberModelCopyWith<$Res>(_value.reservedMember, (value) {
      return _then(_value.copyWith(reservedMember: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ReservationModelCopyWith<$Res>
    implements $ReservationModelCopyWith<$Res> {
  factory _$$_ReservationModelCopyWith(
          _$_ReservationModel value, $Res Function(_$_ReservationModel) then) =
      __$$_ReservationModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      @TimestampConverter() Timestamp date,
      String time,
      @ReservedMemberConverter() ReservedMemberModel reservedMember,
      @TimestampConverter() Timestamp createdAt,
      @TimestampConverter() Timestamp updatedAt});

  @override
  $ReservedMemberModelCopyWith<$Res> get reservedMember;
}

/// @nodoc
class __$$_ReservationModelCopyWithImpl<$Res>
    extends _$ReservationModelCopyWithImpl<$Res, _$_ReservationModel>
    implements _$$_ReservationModelCopyWith<$Res> {
  __$$_ReservationModelCopyWithImpl(
      _$_ReservationModel _value, $Res Function(_$_ReservationModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? date = null,
    Object? time = null,
    Object? reservedMember = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$_ReservationModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      reservedMember: null == reservedMember
          ? _value.reservedMember
          : reservedMember // ignore: cast_nullable_to_non_nullable
              as ReservedMemberModel,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_ReservationModel extends _ReservationModel {
  const _$_ReservationModel(
      {required this.id,
      required this.title,
      @TimestampConverter() required this.date,
      required this.time,
      @ReservedMemberConverter() required this.reservedMember,
      @TimestampConverter() required this.createdAt,
      @TimestampConverter() required this.updatedAt})
      : super._();

  factory _$_ReservationModel.fromJson(Map<String, dynamic> json) =>
      _$$_ReservationModelFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @TimestampConverter()
  final Timestamp date;
  @override
  final String time;
  @override
  @ReservedMemberConverter()
  final ReservedMemberModel reservedMember;
  @override
  @TimestampConverter()
  final Timestamp createdAt;
  @override
  @TimestampConverter()
  final Timestamp updatedAt;

  @override
  String toString() {
    return 'ReservationModel(id: $id, title: $title, date: $date, time: $time, reservedMember: $reservedMember, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReservationModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.reservedMember, reservedMember) ||
                other.reservedMember == reservedMember) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, date, time, reservedMember, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReservationModelCopyWith<_$_ReservationModel> get copyWith =>
      __$$_ReservationModelCopyWithImpl<_$_ReservationModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReservationModelToJson(
      this,
    );
  }
}

abstract class _ReservationModel extends ReservationModel {
  const factory _ReservationModel(
      {required final String id,
      required final String title,
      @TimestampConverter()
          required final Timestamp date,
      required final String time,
      @ReservedMemberConverter()
          required final ReservedMemberModel reservedMember,
      @TimestampConverter()
          required final Timestamp createdAt,
      @TimestampConverter()
          required final Timestamp updatedAt}) = _$_ReservationModel;
  const _ReservationModel._() : super._();

  factory _ReservationModel.fromJson(Map<String, dynamic> json) =
      _$_ReservationModel.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  @TimestampConverter()
  Timestamp get date;
  @override
  String get time;
  @override
  @ReservedMemberConverter()
  ReservedMemberModel get reservedMember;
  @override
  @TimestampConverter()
  Timestamp get createdAt;
  @override
  @TimestampConverter()
  Timestamp get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_ReservationModelCopyWith<_$_ReservationModel> get copyWith =>
      throw _privateConstructorUsedError;
}
