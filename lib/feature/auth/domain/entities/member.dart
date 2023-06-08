import 'package:freezed_annotation/freezed_annotation.dart';

import '../values/belongings/belonging.dart';
import '../values/institute_grade.dart';
import '../values/user_state.dart';

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
  }) = _Member;
}
