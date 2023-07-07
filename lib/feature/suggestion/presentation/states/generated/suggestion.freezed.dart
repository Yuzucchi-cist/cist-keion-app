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
  SuggestionCategory get category => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

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
  $Res call({SuggestionCategory category, String description});
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
    Object? category = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as SuggestionCategory,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
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
  $Res call({SuggestionCategory category, String description});
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
    Object? category = null,
    Object? description = null,
  }) {
    return _then(_$_Suggestion(
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as SuggestionCategory,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Suggestion implements _Suggestion {
  const _$_Suggestion({required this.category, required this.description});

  @override
  final SuggestionCategory category;
  @override
  final String description;

  @override
  String toString() {
    return 'Suggestion(category: $category, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Suggestion &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SuggestionCopyWith<_$_Suggestion> get copyWith =>
      __$$_SuggestionCopyWithImpl<_$_Suggestion>(this, _$identity);
}

abstract class _Suggestion implements Suggestion {
  const factory _Suggestion(
      {required final SuggestionCategory category,
      required final String description}) = _$_Suggestion;

  @override
  SuggestionCategory get category;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$_SuggestionCopyWith<_$_Suggestion> get copyWith =>
      throw _privateConstructorUsedError;
}
