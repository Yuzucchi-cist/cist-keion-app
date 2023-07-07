// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../belonging_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BelongingModel _$BelongingModelFromJson(Map<String, dynamic> json) {
  return _BelongingModel.fromJson(json);
}

/// @nodoc
mixin _$BelongingModel {
  String get id => throw _privateConstructorUsedError;
  BelongingType get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BelongingModelCopyWith<BelongingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BelongingModelCopyWith<$Res> {
  factory $BelongingModelCopyWith(
          BelongingModel value, $Res Function(BelongingModel) then) =
      _$BelongingModelCopyWithImpl<$Res, BelongingModel>;
  @useResult
  $Res call({String id, BelongingType type, String name});
}

/// @nodoc
class _$BelongingModelCopyWithImpl<$Res, $Val extends BelongingModel>
    implements $BelongingModelCopyWith<$Res> {
  _$BelongingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BelongingType,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BelongingModelCopyWith<$Res>
    implements $BelongingModelCopyWith<$Res> {
  factory _$$_BelongingModelCopyWith(
          _$_BelongingModel value, $Res Function(_$_BelongingModel) then) =
      __$$_BelongingModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, BelongingType type, String name});
}

/// @nodoc
class __$$_BelongingModelCopyWithImpl<$Res>
    extends _$BelongingModelCopyWithImpl<$Res, _$_BelongingModel>
    implements _$$_BelongingModelCopyWith<$Res> {
  __$$_BelongingModelCopyWithImpl(
      _$_BelongingModel _value, $Res Function(_$_BelongingModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
  }) {
    return _then(_$_BelongingModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BelongingType,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_BelongingModel implements _BelongingModel {
  const _$_BelongingModel(
      {required this.id, required this.type, required this.name});

  factory _$_BelongingModel.fromJson(Map<String, dynamic> json) =>
      _$$_BelongingModelFromJson(json);

  @override
  final String id;
  @override
  final BelongingType type;
  @override
  final String name;

  @override
  String toString() {
    return 'BelongingModel(id: $id, type: $type, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BelongingModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BelongingModelCopyWith<_$_BelongingModel> get copyWith =>
      __$$_BelongingModelCopyWithImpl<_$_BelongingModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BelongingModelToJson(
      this,
    );
  }
}

abstract class _BelongingModel implements BelongingModel {
  const factory _BelongingModel(
      {required final String id,
      required final BelongingType type,
      required final String name}) = _$_BelongingModel;

  factory _BelongingModel.fromJson(Map<String, dynamic> json) =
      _$_BelongingModel.fromJson;

  @override
  String get id;
  @override
  BelongingType get type;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_BelongingModelCopyWith<_$_BelongingModel> get copyWith =>
      throw _privateConstructorUsedError;
}
