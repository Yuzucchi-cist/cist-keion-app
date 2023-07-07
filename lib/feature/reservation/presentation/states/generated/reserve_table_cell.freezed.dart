// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../reserve_table_cell.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReserveTableCell {
  String get title => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  String? get reserveMemberId => throw _privateConstructorUsedError;
  String? get reserveMemberName => throw _privateConstructorUsedError;
  bool get isTapped => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReserveTableCellCopyWith<ReserveTableCell> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReserveTableCellCopyWith<$Res> {
  factory $ReserveTableCellCopyWith(
          ReserveTableCell value, $Res Function(ReserveTableCell) then) =
      _$ReserveTableCellCopyWithImpl<$Res, ReserveTableCell>;
  @useResult
  $Res call(
      {String title,
      String? id,
      String? reserveMemberId,
      String? reserveMemberName,
      bool isTapped});
}

/// @nodoc
class _$ReserveTableCellCopyWithImpl<$Res, $Val extends ReserveTableCell>
    implements $ReserveTableCellCopyWith<$Res> {
  _$ReserveTableCellCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? id = freezed,
    Object? reserveMemberId = freezed,
    Object? reserveMemberName = freezed,
    Object? isTapped = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      reserveMemberId: freezed == reserveMemberId
          ? _value.reserveMemberId
          : reserveMemberId // ignore: cast_nullable_to_non_nullable
              as String?,
      reserveMemberName: freezed == reserveMemberName
          ? _value.reserveMemberName
          : reserveMemberName // ignore: cast_nullable_to_non_nullable
              as String?,
      isTapped: null == isTapped
          ? _value.isTapped
          : isTapped // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReserveTableCellCopyWith<$Res>
    implements $ReserveTableCellCopyWith<$Res> {
  factory _$$_ReserveTableCellCopyWith(
          _$_ReserveTableCell value, $Res Function(_$_ReserveTableCell) then) =
      __$$_ReserveTableCellCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String? id,
      String? reserveMemberId,
      String? reserveMemberName,
      bool isTapped});
}

/// @nodoc
class __$$_ReserveTableCellCopyWithImpl<$Res>
    extends _$ReserveTableCellCopyWithImpl<$Res, _$_ReserveTableCell>
    implements _$$_ReserveTableCellCopyWith<$Res> {
  __$$_ReserveTableCellCopyWithImpl(
      _$_ReserveTableCell _value, $Res Function(_$_ReserveTableCell) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? id = freezed,
    Object? reserveMemberId = freezed,
    Object? reserveMemberName = freezed,
    Object? isTapped = null,
  }) {
    return _then(_$_ReserveTableCell(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      reserveMemberId: freezed == reserveMemberId
          ? _value.reserveMemberId
          : reserveMemberId // ignore: cast_nullable_to_non_nullable
              as String?,
      reserveMemberName: freezed == reserveMemberName
          ? _value.reserveMemberName
          : reserveMemberName // ignore: cast_nullable_to_non_nullable
              as String?,
      isTapped: null == isTapped
          ? _value.isTapped
          : isTapped // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ReserveTableCell extends _ReserveTableCell {
  const _$_ReserveTableCell(
      {required this.title,
      this.id,
      this.reserveMemberId,
      this.reserveMemberName,
      this.isTapped = false})
      : super._();

  @override
  final String title;
  @override
  final String? id;
  @override
  final String? reserveMemberId;
  @override
  final String? reserveMemberName;
  @override
  @JsonKey()
  final bool isTapped;

  @override
  String toString() {
    return 'ReserveTableCell(title: $title, id: $id, reserveMemberId: $reserveMemberId, reserveMemberName: $reserveMemberName, isTapped: $isTapped)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReserveTableCell &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.reserveMemberId, reserveMemberId) ||
                other.reserveMemberId == reserveMemberId) &&
            (identical(other.reserveMemberName, reserveMemberName) ||
                other.reserveMemberName == reserveMemberName) &&
            (identical(other.isTapped, isTapped) ||
                other.isTapped == isTapped));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, title, id, reserveMemberId, reserveMemberName, isTapped);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReserveTableCellCopyWith<_$_ReserveTableCell> get copyWith =>
      __$$_ReserveTableCellCopyWithImpl<_$_ReserveTableCell>(this, _$identity);
}

abstract class _ReserveTableCell extends ReserveTableCell {
  const factory _ReserveTableCell(
      {required final String title,
      final String? id,
      final String? reserveMemberId,
      final String? reserveMemberName,
      final bool isTapped}) = _$_ReserveTableCell;
  const _ReserveTableCell._() : super._();

  @override
  String get title;
  @override
  String? get id;
  @override
  String? get reserveMemberId;
  @override
  String? get reserveMemberName;
  @override
  bool get isTapped;
  @override
  @JsonKey(ignore: true)
  _$$_ReserveTableCellCopyWith<_$_ReserveTableCell> get copyWith =>
      throw _privateConstructorUsedError;
}
