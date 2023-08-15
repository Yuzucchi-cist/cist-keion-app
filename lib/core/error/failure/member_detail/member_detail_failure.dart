import '../failure.dart';
import 'member_detail_failure_state.dart';

class MemberDetailFailure extends Failure {
  MemberDetailFailure([this.state = MemberDetailFailureState.unexpected])
      : super([state]);

  factory MemberDetailFailure.fromDataSourceExceptionCode(String code) {
    final MemberDetailFailureState state;
    switch (code) {
      case 'no-file':
        state = MemberDetailFailureState.noFile;
      case 'illegal-file-type':
        state = MemberDetailFailureState.ilegalFileType;
      case 'illegal-table-format':
        state = MemberDetailFailureState.illegalTableFormat;
      default:
        state = MemberDetailFailureState.unexpected;
    }
    return MemberDetailFailure(state);
  }

  final MemberDetailFailureState state;
}
