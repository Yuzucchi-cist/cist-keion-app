// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../reserved_member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ReservedMember {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReservedMemberCopyWith<ReservedMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservedMemberCopyWith<$Res> {
  factory $ReservedMemberCopyWith(
          ReservedMember value, $Res Function(ReservedMember) then) =
      _$ReservedMemberCopyWithImpl<$Res, ReservedMember>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$ReservedMemberCopyWithImpl<$Res, $Val extends ReservedMember>
    implements $ReservedMemberCopyWith<$Res> {
  _$ReservedMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReservedMemberCopyWith<$Res>
    implements $ReservedMemberCopyWith<$Res> {
  factory _$$_ReservedMemberCopyWith(
          _$_ReservedMember value, $Res Function(_$_ReservedMember) then) =
      __$$_ReservedMemberCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$_ReservedMemberCopyWithImpl<$Res>
    extends _$ReservedMemberCopyWithImpl<$Res, _$_ReservedMember>
    implements _$$_ReservedMemberCopyWith<$Res> {
  __$$_ReservedMemberCopyWithImpl(
      _$_ReservedMember _value, $Res Function(_$_ReservedMember) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$_ReservedMember(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ReservedMember implements _ReservedMember {
  const _$_ReservedMember({required this.id, required this.name});

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'ReservedMember(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReservedMember &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReservedMemberCopyWith<_$_ReservedMember> get copyWith =>
      __$$_ReservedMemberCopyWithImpl<_$_ReservedMember>(this, _$identity);
}

abstract class _ReservedMember implements ReservedMember {
  const factory _ReservedMember(
      {required final String id,
      required final String name}) = _$_ReservedMember;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_ReservedMemberCopyWith<_$_ReservedMember> get copyWith =>
      throw _privateConstructorUsedError;
}
