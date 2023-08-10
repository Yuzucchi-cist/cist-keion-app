// ignore_for_file: sort_unnamed_constructors_first

import 'package:freezed_annotation/freezed_annotation.dart';

import 'belonging_model.dart';
import 'institute_grade_model.dart';
import 'user_state_model.dart';

part 'generated/member_detail_model.freezed.dart';
part 'generated/member_detail_model.g.dart';

@freezed
class MemberDetailModel with _$MemberDetailModel {
  const MemberDetailModel._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MemberDetailModel({
    required String id,
    required String studentNumber,
    required String name,
    required InstituteGradeModel instituteGrade,
    required UserStateModel userState,
    @BelongingModelListConverter() required List<BelongingModel> belongings,
    @Default(false) bool isAdmin,
  }) = _MemberDetailModel;

  factory MemberDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MemberDetailModelFromJson(json);

  factory MemberDetailModel.fromFirestoreJson(
      String id, Map<String, dynamic> json) {
    final convertedJson = {'id': id, ...json};
    return MemberDetailModel.fromJson(convertedJson);
  }

  Map<String, dynamic> toFirestoreJson() {
    return toJson()..remove('id');
  }
}

class BelongingModelListConverter
    implements JsonConverter<List<BelongingModel>, List<dynamic>> {
  const BelongingModelListConverter();

  @override
  List<BelongingModel> fromJson(List<dynamic> json) {
    return json
        .map((e) => BelongingModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  List<dynamic> toJson(List<BelongingModel> object) {
    return object.map((e) => e.toJson()).toList();
  }
}
