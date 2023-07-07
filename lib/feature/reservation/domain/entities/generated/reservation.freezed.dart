// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../reservation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Reservation {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  ReservedMember get reservedMember => throw _privateConstructorUsedError;
  InstituteTime get time => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReservationCopyWith<Reservation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationCopyWith<$Res> {
  factory $ReservationCopyWith(
          Reservation value, $Res Function(Reservation) then) =
      _$ReservationCopyWithImpl<$Res, Reservation>;
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime date,
      ReservedMember reservedMember,
      InstituteTime time,
      DateTime? createdAt,
      DateTime? updatedAt});

  $ReservedMemberCopyWith<$Res> get reservedMember;
}

/// @nodoc
class _$ReservationCopyWithImpl<$Res, $Val extends Reservation>
    implements $ReservationCopyWith<$Res> {
  _$ReservationCopyWithImpl(this._value, this._then);

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
    Object? reservedMember = null,
    Object? time = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
              as DateTime,
      reservedMember: null == reservedMember
          ? _value.reservedMember
          : reservedMember // ignore: cast_nullable_to_non_nullable
              as ReservedMember,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as InstituteTime,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ReservedMemberCopyWith<$Res> get reservedMember {
    return $ReservedMemberCopyWith<$Res>(_value.reservedMember, (value) {
      return _then(_value.copyWith(reservedMember: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ReservationCopyWith<$Res>
    implements $ReservationCopyWith<$Res> {
  factory _$$_ReservationCopyWith(
          _$_Reservation value, $Res Function(_$_Reservation) then) =
      __$$_ReservationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime date,
      ReservedMember reservedMember,
      InstituteTime time,
      DateTime? createdAt,
      DateTime? updatedAt});

  @override
  $ReservedMemberCopyWith<$Res> get reservedMember;
}

/// @nodoc
class __$$_ReservationCopyWithImpl<$Res>
    extends _$ReservationCopyWithImpl<$Res, _$_Reservation>
    implements _$$_ReservationCopyWith<$Res> {
  __$$_ReservationCopyWithImpl(
      _$_Reservation _value, $Res Function(_$_Reservation) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? date = null,
    Object? reservedMember = null,
    Object? time = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_Reservation(
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
              as DateTime,
      reservedMember: null == reservedMember
          ? _value.reservedMember
          : reservedMember // ignore: cast_nullable_to_non_nullable
              as ReservedMember,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as InstituteTime,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$_Reservation implements _Reservation {
  const _$_Reservation(
      {required this.id,
      required this.title,
      required this.date,
      required this.reservedMember,
      required this.time,
      this.createdAt,
      this.updatedAt});

  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime date;
  @override
  final ReservedMember reservedMember;
  @override
  final InstituteTime time;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Reservation(id: $id, title: $title, date: $date, reservedMember: $reservedMember, time: $time, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Reservation &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.reservedMember, reservedMember) ||
                other.reservedMember == reservedMember) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, date, reservedMember, time, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReservationCopyWith<_$_Reservation> get copyWith =>
      __$$_ReservationCopyWithImpl<_$_Reservation>(this, _$identity);
}

abstract class _Reservation implements Reservation {
  const factory _Reservation(
      {required final String id,
      required final String title,
      required final DateTime date,
      required final ReservedMember reservedMember,
      required final InstituteTime time,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$_Reservation;

  @override
  String get id;
  @override
  String get title;
  @override
  DateTime get date;
  @override
  ReservedMember get reservedMember;
  @override
  InstituteTime get time;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_ReservationCopyWith<_$_Reservation> get copyWith =>
      throw _privateConstructorUsedError;
}
