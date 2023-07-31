import 'package:freezed_annotation/freezed_annotation.dart';

import '../../value/belongings/belonging.dart';
import '../../value/institute_grade.dart';
import '../../value/user_state.dart';

part 'generated/member.freezed.dart';

@freezed
class Member with _$Member {
  const factory Member({
    required String memberId,
    required String studentNumber,
    required String name,
    required InstituteGrade instituteGrade,
    required UserState userState,
    required bool isVerified,
    @Default([]) List<Belonging> belongings,
    @Default(false) bool isAdmin,
  }) = _Member;
}
