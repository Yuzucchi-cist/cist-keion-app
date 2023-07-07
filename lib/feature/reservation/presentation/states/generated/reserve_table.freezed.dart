// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../reserve_table.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReserveTable {
  Map<({InstituteTime time, WeekDay weekDay}), ReserveTableCell> get table =>
      throw _privateConstructorUsedError;
  DateTime get startDateOfWeek => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReserveTableCopyWith<ReserveTable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReserveTableCopyWith<$Res> {
  factory $ReserveTableCopyWith(
          ReserveTable value, $Res Function(ReserveTable) then) =
      _$ReserveTableCopyWithImpl<$Res, ReserveTable>;
  @useResult
  $Res call(
      {Map<({InstituteTime time, WeekDay weekDay}), ReserveTableCell> table,
      DateTime startDateOfWeek});
}

/// @nodoc
class _$ReserveTableCopyWithImpl<$Res, $Val extends ReserveTable>
    implements $ReserveTableCopyWith<$Res> {
  _$ReserveTableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? table = null,
    Object? startDateOfWeek = null,
  }) {
    return _then(_value.copyWith(
      table: null == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as Map<({InstituteTime time, WeekDay weekDay}), ReserveTableCell>,
      startDateOfWeek: null == startDateOfWeek
          ? _value.startDateOfWeek
          : startDateOfWeek // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReserveTableCopyWith<$Res>
    implements $ReserveTableCopyWith<$Res> {
  factory _$$_ReserveTableCopyWith(
          _$_ReserveTable value, $Res Function(_$_ReserveTable) then) =
      __$$_ReserveTableCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<({InstituteTime time, WeekDay weekDay}), ReserveTableCell> table,
      DateTime startDateOfWeek});
}

/// @nodoc
class __$$_ReserveTableCopyWithImpl<$Res>
    extends _$ReserveTableCopyWithImpl<$Res, _$_ReserveTable>
    implements _$$_ReserveTableCopyWith<$Res> {
  __$$_ReserveTableCopyWithImpl(
      _$_ReserveTable _value, $Res Function(_$_ReserveTable) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? table = null,
    Object? startDateOfWeek = null,
  }) {
    return _then(_$_ReserveTable(
      table: null == table
          ? _value._table
          : table // ignore: cast_nullable_to_non_nullable
              as Map<({InstituteTime time, WeekDay weekDay}), ReserveTableCell>,
      startDateOfWeek: null == startDateOfWeek
          ? _value.startDateOfWeek
          : startDateOfWeek // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_ReserveTable extends _ReserveTable {
  const _$_ReserveTable(
      {required final Map<({InstituteTime time, WeekDay weekDay}),
              ReserveTableCell>
          table,
      required this.startDateOfWeek})
      : _table = table,
        super._();

  final Map<({InstituteTime time, WeekDay weekDay}), ReserveTableCell> _table;
  @override
  Map<({InstituteTime time, WeekDay weekDay}), ReserveTableCell> get table {
    if (_table is EqualUnmodifiableMapView) return _table;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_table);
  }

  @override
  final DateTime startDateOfWeek;

  @override
  String toString() {
    return 'ReserveTable(table: $table, startDateOfWeek: $startDateOfWeek)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReserveTable &&
            const DeepCollectionEquality().equals(other._table, _table) &&
            (identical(other.startDateOfWeek, startDateOfWeek) ||
                other.startDateOfWeek == startDateOfWeek));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_table), startDateOfWeek);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReserveTableCopyWith<_$_ReserveTable> get copyWith =>
      __$$_ReserveTableCopyWithImpl<_$_ReserveTable>(this, _$identity);
}

abstract class _ReserveTable extends ReserveTable {
  const factory _ReserveTable(
      {required final Map<({InstituteTime time, WeekDay weekDay}),
              ReserveTableCell>
          table,
      required final DateTime startDateOfWeek}) = _$_ReserveTable;
  const _ReserveTable._() : super._();

  @override
  Map<({InstituteTime time, WeekDay weekDay}), ReserveTableCell> get table;
  @override
  DateTime get startDateOfWeek;
  @override
  @JsonKey(ignore: true)
  _$$_ReserveTableCopyWith<_$_ReserveTable> get copyWith =>
      throw _privateConstructorUsedError;
}
