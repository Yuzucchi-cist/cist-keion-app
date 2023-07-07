// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../reserved_member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReservedMemberModel _$ReservedMemberModelFromJson(Map<String, dynamic> json) {
  return _ReservedMemberModel.fromJson(json);
}

/// @nodoc
mixin _$ReservedMemberModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReservedMemberModelCopyWith<ReservedMemberModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservedMemberModelCopyWith<$Res> {
  factory $ReservedMemberModelCopyWith(
          ReservedMemberModel value, $Res Function(ReservedMemberModel) then) =
      _$ReservedMemberModelCopyWithImpl<$Res, ReservedMemberModel>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class _$ReservedMemberModelCopyWithImpl<$Res, $Val extends ReservedMemberModel>
    implements $ReservedMemberModelCopyWith<$Res> {
  _$ReservedMemberModelCopyWithImpl(this._value, this._then);

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
abstract class _$$_ReservedMemberModelCopyWith<$Res>
    implements $ReservedMemberModelCopyWith<$Res> {
  factory _$$_ReservedMemberModelCopyWith(_$_ReservedMemberModel value,
          $Res Function(_$_ReservedMemberModel) then) =
      __$$_ReservedMemberModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$_ReservedMemberModelCopyWithImpl<$Res>
    extends _$ReservedMemberModelCopyWithImpl<$Res, _$_ReservedMemberModel>
    implements _$$_ReservedMemberModelCopyWith<$Res> {
  __$$_ReservedMemberModelCopyWithImpl(_$_ReservedMemberModel _value,
      $Res Function(_$_ReservedMemberModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$_ReservedMemberModel(
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

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_ReservedMemberModel implements _ReservedMemberModel {
  const _$_ReservedMemberModel({required this.id, required this.name});

  factory _$_ReservedMemberModel.fromJson(Map<String, dynamic> json) =>
      _$$_ReservedMemberModelFromJson(json);

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'ReservedMemberModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReservedMemberModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReservedMemberModelCopyWith<_$_ReservedMemberModel> get copyWith =>
      __$$_ReservedMemberModelCopyWithImpl<_$_ReservedMemberModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReservedMemberModelToJson(
      this,
    );
  }
}

abstract class _ReservedMemberModel implements ReservedMemberModel {
  const factory _ReservedMemberModel(
      {required final String id,
      required final String name}) = _$_ReservedMemberModel;

  factory _ReservedMemberModel.fromJson(Map<String, dynamic> json) =
      _$_ReservedMemberModel.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_ReservedMemberModelCopyWith<_$_ReservedMemberModel> get copyWith =>
      throw _privateConstructorUsedError;
}
