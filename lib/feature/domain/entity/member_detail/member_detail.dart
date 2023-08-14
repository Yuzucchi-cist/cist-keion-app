import 'package:freezed_annotation/freezed_annotation.dart';

import '../../value/belongings/belonging.dart';
import '../../value/institute_grade.dart';
import '../../value/user_state.dart';

part 'generated/member_detail.freezed.dart';

@freezed
class MemberDetail with _$MemberDetail {
  const factory MemberDetail({
    @Default('') String id,
    required String studentNumber,
    required String name,
    required InstituteGrade instituteGrade,
    @Default(UserState.active) UserState userState,
    @Default([]) List<Belonging> belongings,
    @Default(false) bool isAdmin,
  }) = _MemberDetail;
}
