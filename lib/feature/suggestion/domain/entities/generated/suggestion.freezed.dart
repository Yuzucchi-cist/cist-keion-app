// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../suggestion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Suggestion {
  String get id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  SuggestionCategory get category => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SuggestionCopyWith<Suggestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuggestionCopyWith<$Res> {
  factory $SuggestionCopyWith(
          Suggestion value, $Res Function(Suggestion) then) =
      _$SuggestionCopyWithImpl<$Res, Suggestion>;
  @useResult
  $Res call(
      {String id,
      String description,
      SuggestionCategory category,
      DateTime? createdAt});
}

/// @nodoc
class _$SuggestionCopyWithImpl<$Res, $Val extends Suggestion>
    implements $SuggestionCopyWith<$Res> {
  _$SuggestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
    Object? category = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as SuggestionCategory,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SuggestionCopyWith<$Res>
    implements $SuggestionCopyWith<$Res> {
  factory _$$_SuggestionCopyWith(
          _$_Suggestion value, $Res Function(_$_Suggestion) then) =
      __$$_SuggestionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String description,
      SuggestionCategory category,
      DateTime? createdAt});
}

/// @nodoc
class __$$_SuggestionCopyWithImpl<$Res>
    extends _$SuggestionCopyWithImpl<$Res, _$_Suggestion>
    implements _$$_SuggestionCopyWith<$Res> {
  __$$_SuggestionCopyWithImpl(
      _$_Suggestion _value, $Res Function(_$_Suggestion) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? description = null,
    Object? category = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$_Suggestion(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as SuggestionCategory,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$_Suggestion implements _Suggestion {
  const _$_Suggestion(
      {required this.id,
      required this.description,
      required this.category,
      this.createdAt});

  @override
  final String id;
  @override
  final String description;
  @override
  final SuggestionCategory category;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Suggestion(id: $id, description: $description, category: $category, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Suggestion &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, description, category, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SuggestionCopyWith<_$_Suggestion> get copyWith =>
      __$$_SuggestionCopyWithImpl<_$_Suggestion>(this, _$identity);
}

abstract class _Suggestion implements Suggestion {
  const factory _Suggestion(
      {required final String id,
      required final String description,
      required final SuggestionCategory category,
      final DateTime? createdAt}) = _$_Suggestion;

  @override
  String get id;
  @override
  String get description;
  @override
  SuggestionCategory get category;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_SuggestionCopyWith<_$_Suggestion> get copyWith =>
      throw _privateConstructorUsedError;
}
