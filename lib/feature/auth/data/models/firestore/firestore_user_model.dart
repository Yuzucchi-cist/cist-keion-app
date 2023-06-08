import 'package:freezed_annotation/freezed_annotation.dart';

import 'belonging_model.dart';
import 'institute_grade_model.dart';
import 'user_state_model.dart';

part 'generated/firestore_user_model.freezed.dart';

@freezed
class FirestoreUserModel with _$FirestoreUserModel {
  const factory FirestoreUserModel({
    required String id,
    required String studentNumber,
    required String name,
    required InstituteGradeModel instituteGrade,
    required UserStateModel userState,
    required List<BelongingModel<dynamic>> belongings,
  }) = _FirestoreUserModel;
}
