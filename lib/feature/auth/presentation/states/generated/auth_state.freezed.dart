// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unAuthenticated,
    required TResult Function(Member member) unVerified,
    required TResult Function(Member member) authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unAuthenticated,
    TResult? Function(Member member)? unVerified,
    TResult? Function(Member member)? authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unAuthenticated,
    TResult Function(Member member)? unVerified,
    TResult Function(Member member)? authenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_unAuthenticated value) unAuthenticated,
    required TResult Function(_unVerified value) unVerified,
    required TResult Function(_authenticated value) authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_unAuthenticated value)? unAuthenticated,
    TResult? Function(_unVerified value)? unVerified,
    TResult? Function(_authenticated value)? authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_unAuthenticated value)? unAuthenticated,
    TResult Function(_unVerified value)? unVerified,
    TResult Function(_authenticated value)? authenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_unAuthenticatedCopyWith<$Res> {
  factory _$$_unAuthenticatedCopyWith(
          _$_unAuthenticated value, $Res Function(_$_unAuthenticated) then) =
      __$$_unAuthenticatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_unAuthenticatedCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_unAuthenticated>
    implements _$$_unAuthenticatedCopyWith<$Res> {
  __$$_unAuthenticatedCopyWithImpl(
      _$_unAuthenticated _value, $Res Function(_$_unAuthenticated) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_unAuthenticated extends _unAuthenticated {
  const _$_unAuthenticated() : super._();

  @override
  String toString() {
    return 'AuthState.unAuthenticated()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_unAuthenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unAuthenticated,
    required TResult Function(Member member) unVerified,
    required TResult Function(Member member) authenticated,
  }) {
    return unAuthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unAuthenticated,
    TResult? Function(Member member)? unVerified,
    TResult? Function(Member member)? authenticated,
  }) {
    return unAuthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unAuthenticated,
    TResult Function(Member member)? unVerified,
    TResult Function(Member member)? authenticated,
    required TResult orElse(),
  }) {
    if (unAuthenticated != null) {
      return unAuthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_unAuthenticated value) unAuthenticated,
    required TResult Function(_unVerified value) unVerified,
    required TResult Function(_authenticated value) authenticated,
  }) {
    return unAuthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_unAuthenticated value)? unAuthenticated,
    TResult? Function(_unVerified value)? unVerified,
    TResult? Function(_authenticated value)? authenticated,
  }) {
    return unAuthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_unAuthenticated value)? unAuthenticated,
    TResult Function(_unVerified value)? unVerified,
    TResult Function(_authenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (unAuthenticated != null) {
      return unAuthenticated(this);
    }
    return orElse();
  }
}

abstract class _unAuthenticated extends AuthState {
  const factory _unAuthenticated() = _$_unAuthenticated;
  const _unAuthenticated._() : super._();
}

/// @nodoc
abstract class _$$_unVerifiedCopyWith<$Res> {
  factory _$$_unVerifiedCopyWith(
          _$_unVerified value, $Res Function(_$_unVerified) then) =
      __$$_unVerifiedCopyWithImpl<$Res>;
  @useResult
  $Res call({Member member});

  $MemberCopyWith<$Res> get member;
}

/// @nodoc
class __$$_unVerifiedCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_unVerified>
    implements _$$_unVerifiedCopyWith<$Res> {
  __$$_unVerifiedCopyWithImpl(
      _$_unVerified _value, $Res Function(_$_unVerified) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? member = null,
  }) {
    return _then(_$_unVerified(
      null == member
          ? _value.member
          : member // ignore: cast_nullable_to_non_nullable
              as Member,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $MemberCopyWith<$Res> get member {
    return $MemberCopyWith<$Res>(_value.member, (value) {
      return _then(_value.copyWith(member: value));
    });
  }
}

/// @nodoc

class _$_unVerified extends _unVerified {
  const _$_unVerified(this.member) : super._();

  @override
  final Member member;

  @override
  String toString() {
    return 'AuthState.unVerified(member: $member)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_unVerified &&
            (identical(other.member, member) || other.member == member));
  }

  @override
  int get hashCode => Object.hash(runtimeType, member);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_unVerifiedCopyWith<_$_unVerified> get copyWith =>
      __$$_unVerifiedCopyWithImpl<_$_unVerified>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unAuthenticated,
    required TResult Function(Member member) unVerified,
    required TResult Function(Member member) authenticated,
  }) {
    return unVerified(member);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unAuthenticated,
    TResult? Function(Member member)? unVerified,
    TResult? Function(Member member)? authenticated,
  }) {
    return unVerified?.call(member);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unAuthenticated,
    TResult Function(Member member)? unVerified,
    TResult Function(Member member)? authenticated,
    required TResult orElse(),
  }) {
    if (unVerified != null) {
      return unVerified(member);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_unAuthenticated value) unAuthenticated,
    required TResult Function(_unVerified value) unVerified,
    required TResult Function(_authenticated value) authenticated,
  }) {
    return unVerified(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_unAuthenticated value)? unAuthenticated,
    TResult? Function(_unVerified value)? unVerified,
    TResult? Function(_authenticated value)? authenticated,
  }) {
    return unVerified?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_unAuthenticated value)? unAuthenticated,
    TResult Function(_unVerified value)? unVerified,
    TResult Function(_authenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (unVerified != null) {
      return unVerified(this);
    }
    return orElse();
  }
}

abstract class _unVerified extends AuthState {
  const factory _unVerified(final Member member) = _$_unVerified;
  const _unVerified._() : super._();

  Member get member;
  @JsonKey(ignore: true)
  _$$_unVerifiedCopyWith<_$_unVerified> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_authenticatedCopyWith<$Res> {
  factory _$$_authenticatedCopyWith(
          _$_authenticated value, $Res Function(_$_authenticated) then) =
      __$$_authenticatedCopyWithImpl<$Res>;
  @useResult
  $Res call({Member member});

  $MemberCopyWith<$Res> get member;
}

/// @nodoc
class __$$_authenticatedCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$_authenticated>
    implements _$$_authenticatedCopyWith<$Res> {
  __$$_authenticatedCopyWithImpl(
      _$_authenticated _value, $Res Function(_$_authenticated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? member = null,
  }) {
    return _then(_$_authenticated(
      null == member
          ? _value.member
          : member // ignore: cast_nullable_to_non_nullable
              as Member,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $MemberCopyWith<$Res> get member {
    return $MemberCopyWith<$Res>(_value.member, (value) {
      return _then(_value.copyWith(member: value));
    });
  }
}

/// @nodoc

class _$_authenticated extends _authenticated {
  const _$_authenticated(this.member) : super._();

  @override
  final Member member;

  @override
  String toString() {
    return 'AuthState.authenticated(member: $member)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_authenticated &&
            (identical(other.member, member) || other.member == member));
  }

  @override
  int get hashCode => Object.hash(runtimeType, member);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_authenticatedCopyWith<_$_authenticated> get copyWith =>
      __$$_authenticatedCopyWithImpl<_$_authenticated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unAuthenticated,
    required TResult Function(Member member) unVerified,
    required TResult Function(Member member) authenticated,
  }) {
    return authenticated(member);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unAuthenticated,
    TResult? Function(Member member)? unVerified,
    TResult? Function(Member member)? authenticated,
  }) {
    return authenticated?.call(member);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unAuthenticated,
    TResult Function(Member member)? unVerified,
    TResult Function(Member member)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(member);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_unAuthenticated value) unAuthenticated,
    required TResult Function(_unVerified value) unVerified,
    required TResult Function(_authenticated value) authenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_unAuthenticated value)? unAuthenticated,
    TResult? Function(_unVerified value)? unVerified,
    TResult? Function(_authenticated value)? authenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_unAuthenticated value)? unAuthenticated,
    TResult Function(_unVerified value)? unVerified,
    TResult Function(_authenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _authenticated extends AuthState {
  const factory _authenticated(final Member member) = _$_authenticated;
  const _authenticated._() : super._();

  Member get member;
  @JsonKey(ignore: true)
  _$$_authenticatedCopyWith<_$_authenticated> get copyWith =>
      throw _privateConstructorUsedError;
}
