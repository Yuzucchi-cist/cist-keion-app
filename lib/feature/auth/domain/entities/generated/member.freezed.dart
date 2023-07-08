// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../member.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Member {
  String get memberId => throw _privateConstructorUsedError;
  String get studentNumber => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  InstituteGrade get instituteGrade => throw _privateConstructorUsedError;
  UserState get userState => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  List<Belonging> get belongings => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MemberCopyWith<Member> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemberCopyWith<$Res> {
  factory $MemberCopyWith(Member value, $Res Function(Member) then) =
      _$MemberCopyWithImpl<$Res, Member>;
  @useResult
  $Res call(
      {String memberId,
      String studentNumber,
      String name,
      InstituteGrade instituteGrade,
      UserState userState,
      bool isVerified,
      List<Belonging> belongings,
      bool isAdmin});
}

/// @nodoc
class _$MemberCopyWithImpl<$Res, $Val extends Member>
    implements $MemberCopyWith<$Res> {
  _$MemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? studentNumber = null,
    Object? name = null,
    Object? instituteGrade = null,
    Object? userState = null,
    Object? isVerified = null,
    Object? belongings = null,
    Object? isAdmin = null,
  }) {
    return _then(_value.copyWith(
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      studentNumber: null == studentNumber
          ? _value.studentNumber
          : studentNumber // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      instituteGrade: null == instituteGrade
          ? _value.instituteGrade
          : instituteGrade // ignore: cast_nullable_to_non_nullable
              as InstituteGrade,
      userState: null == userState
          ? _value.userState
          : userState // ignore: cast_nullable_to_non_nullable
              as UserState,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      belongings: null == belongings
          ? _value.belongings
          : belongings // ignore: cast_nullable_to_non_nullable
              as List<Belonging>,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MemberCopyWith<$Res> implements $MemberCopyWith<$Res> {
  factory _$$_MemberCopyWith(_$_Member value, $Res Function(_$_Member) then) =
      __$$_MemberCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String memberId,
      String studentNumber,
      String name,
      InstituteGrade instituteGrade,
      UserState userState,
      bool isVerified,
      List<Belonging> belongings,
      bool isAdmin});
}

/// @nodoc
class __$$_MemberCopyWithImpl<$Res>
    extends _$MemberCopyWithImpl<$Res, _$_Member>
    implements _$$_MemberCopyWith<$Res> {
  __$$_MemberCopyWithImpl(_$_Member _value, $Res Function(_$_Member) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? studentNumber = null,
    Object? name = null,
    Object? instituteGrade = null,
    Object? userState = null,
    Object? isVerified = null,
    Object? belongings = null,
    Object? isAdmin = null,
  }) {
    return _then(_$_Member(
      memberId: null == memberId
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as String,
      studentNumber: null == studentNumber
          ? _value.studentNumber
          : studentNumber // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      instituteGrade: null == instituteGrade
          ? _value.instituteGrade
          : instituteGrade // ignore: cast_nullable_to_non_nullable
              as InstituteGrade,
      userState: null == userState
          ? _value.userState
          : userState // ignore: cast_nullable_to_non_nullable
              as UserState,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      belongings: null == belongings
          ? _value._belongings
          : belongings // ignore: cast_nullable_to_non_nullable
              as List<Belonging>,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_Member implements _Member {
  const _$_Member(
      {required this.memberId,
      required this.studentNumber,
      required this.name,
      required this.instituteGrade,
      required this.userState,
      required this.isVerified,
      final List<Belonging> belongings = const [],
      this.isAdmin = false})
      : _belongings = belongings;

  @override
  final String memberId;
  @override
  final String studentNumber;
  @override
  final String name;
  @override
  final InstituteGrade instituteGrade;
  @override
  final UserState userState;
  @override
  final bool isVerified;
  final List<Belonging> _belongings;
  @override
  @JsonKey()
  List<Belonging> get belongings {
    if (_belongings is EqualUnmodifiableListView) return _belongings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_belongings);
  }

  @override
  @JsonKey()
  final bool isAdmin;

  @override
  String toString() {
    return 'Member(memberId: $memberId, studentNumber: $studentNumber, name: $name, instituteGrade: $instituteGrade, userState: $userState, isVerified: $isVerified, belongings: $belongings, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Member &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.studentNumber, studentNumber) ||
                other.studentNumber == studentNumber) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.instituteGrade, instituteGrade) ||
                other.instituteGrade == instituteGrade) &&
            (identical(other.userState, userState) ||
                other.userState == userState) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            const DeepCollectionEquality()
                .equals(other._belongings, _belongings) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      memberId,
      studentNumber,
      name,
      instituteGrade,
      userState,
      isVerified,
      const DeepCollectionEquality().hash(_belongings),
      isAdmin);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MemberCopyWith<_$_Member> get copyWith =>
      __$$_MemberCopyWithImpl<_$_Member>(this, _$identity);
}

abstract class _Member implements Member {
  const factory _Member(
      {required final String memberId,
      required final String studentNumber,
      required final String name,
      required final InstituteGrade instituteGrade,
      required final UserState userState,
      required final bool isVerified,
      final List<Belonging> belongings,
      final bool isAdmin}) = _$_Member;

  @override
  String get memberId;
  @override
  String get studentNumber;
  @override
  String get name;
  @override
  InstituteGrade get instituteGrade;
  @override
  UserState get userState;
  @override
  bool get isVerified;
  @override
  List<Belonging> get belongings;
  @override
  bool get isAdmin;
  @override
  @JsonKey(ignore: true)
  _$$_MemberCopyWith<_$_Member> get copyWith =>
      throw _privateConstructorUsedError;
}
