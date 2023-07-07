// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../firestore_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirestoreUserModel _$FirestoreUserModelFromJson(Map<String, dynamic> json) {
  return _FirestoreUserModel.fromJson(json);
}

/// @nodoc
mixin _$FirestoreUserModel {
  String get id => throw _privateConstructorUsedError;
  String get studentNumber => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  InstituteGradeModel get instituteGrade => throw _privateConstructorUsedError;
  UserStateModel get userState => throw _privateConstructorUsedError;
  @BelongingModelListConverter()
  List<BelongingModel> get belongings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirestoreUserModelCopyWith<FirestoreUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirestoreUserModelCopyWith<$Res> {
  factory $FirestoreUserModelCopyWith(
          FirestoreUserModel value, $Res Function(FirestoreUserModel) then) =
      _$FirestoreUserModelCopyWithImpl<$Res, FirestoreUserModel>;
  @useResult
  $Res call(
      {String id,
      String studentNumber,
      String name,
      InstituteGradeModel instituteGrade,
      UserStateModel userState,
      @BelongingModelListConverter() List<BelongingModel> belongings});
}

/// @nodoc
class _$FirestoreUserModelCopyWithImpl<$Res, $Val extends FirestoreUserModel>
    implements $FirestoreUserModelCopyWith<$Res> {
  _$FirestoreUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentNumber = null,
    Object? name = null,
    Object? instituteGrade = null,
    Object? userState = null,
    Object? belongings = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
              as InstituteGradeModel,
      userState: null == userState
          ? _value.userState
          : userState // ignore: cast_nullable_to_non_nullable
              as UserStateModel,
      belongings: null == belongings
          ? _value.belongings
          : belongings // ignore: cast_nullable_to_non_nullable
              as List<BelongingModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FirestoreUserModelCopyWith<$Res>
    implements $FirestoreUserModelCopyWith<$Res> {
  factory _$$_FirestoreUserModelCopyWith(_$_FirestoreUserModel value,
          $Res Function(_$_FirestoreUserModel) then) =
      __$$_FirestoreUserModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String studentNumber,
      String name,
      InstituteGradeModel instituteGrade,
      UserStateModel userState,
      @BelongingModelListConverter() List<BelongingModel> belongings});
}

/// @nodoc
class __$$_FirestoreUserModelCopyWithImpl<$Res>
    extends _$FirestoreUserModelCopyWithImpl<$Res, _$_FirestoreUserModel>
    implements _$$_FirestoreUserModelCopyWith<$Res> {
  __$$_FirestoreUserModelCopyWithImpl(
      _$_FirestoreUserModel _value, $Res Function(_$_FirestoreUserModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentNumber = null,
    Object? name = null,
    Object? instituteGrade = null,
    Object? userState = null,
    Object? belongings = null,
  }) {
    return _then(_$_FirestoreUserModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
              as InstituteGradeModel,
      userState: null == userState
          ? _value.userState
          : userState // ignore: cast_nullable_to_non_nullable
              as UserStateModel,
      belongings: null == belongings
          ? _value._belongings
          : belongings // ignore: cast_nullable_to_non_nullable
              as List<BelongingModel>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_FirestoreUserModel extends _FirestoreUserModel {
  const _$_FirestoreUserModel(
      {required this.id,
      required this.studentNumber,
      required this.name,
      required this.instituteGrade,
      required this.userState,
      @BelongingModelListConverter()
          required final List<BelongingModel> belongings})
      : _belongings = belongings,
        super._();

  factory _$_FirestoreUserModel.fromJson(Map<String, dynamic> json) =>
      _$$_FirestoreUserModelFromJson(json);

  @override
  final String id;
  @override
  final String studentNumber;
  @override
  final String name;
  @override
  final InstituteGradeModel instituteGrade;
  @override
  final UserStateModel userState;
  final List<BelongingModel> _belongings;
  @override
  @BelongingModelListConverter()
  List<BelongingModel> get belongings {
    if (_belongings is EqualUnmodifiableListView) return _belongings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_belongings);
  }

  @override
  String toString() {
    return 'FirestoreUserModel(id: $id, studentNumber: $studentNumber, name: $name, instituteGrade: $instituteGrade, userState: $userState, belongings: $belongings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FirestoreUserModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentNumber, studentNumber) ||
                other.studentNumber == studentNumber) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.instituteGrade, instituteGrade) ||
                other.instituteGrade == instituteGrade) &&
            (identical(other.userState, userState) ||
                other.userState == userState) &&
            const DeepCollectionEquality()
                .equals(other._belongings, _belongings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      studentNumber,
      name,
      instituteGrade,
      userState,
      const DeepCollectionEquality().hash(_belongings));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FirestoreUserModelCopyWith<_$_FirestoreUserModel> get copyWith =>
      __$$_FirestoreUserModelCopyWithImpl<_$_FirestoreUserModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FirestoreUserModelToJson(
      this,
    );
  }
}

abstract class _FirestoreUserModel extends FirestoreUserModel {
  const factory _FirestoreUserModel(
          {required final String id,
          required final String studentNumber,
          required final String name,
          required final InstituteGradeModel instituteGrade,
          required final UserStateModel userState,
          @BelongingModelListConverter()
              required final List<BelongingModel> belongings}) =
      _$_FirestoreUserModel;
  const _FirestoreUserModel._() : super._();

  factory _FirestoreUserModel.fromJson(Map<String, dynamic> json) =
      _$_FirestoreUserModel.fromJson;

  @override
  String get id;
  @override
  String get studentNumber;
  @override
  String get name;
  @override
  InstituteGradeModel get instituteGrade;
  @override
  UserStateModel get userState;
  @override
  @BelongingModelListConverter()
  List<BelongingModel> get belongings;
  @override
  @JsonKey(ignore: true)
  _$$_FirestoreUserModelCopyWith<_$_FirestoreUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
