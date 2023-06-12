import '../failure.dart';
import 'auth_failure_state.dart';

class AuthFailure extends Failure {
  AuthFailure([this.state = AuthFailureState.unexpected]) : super([state]);

  factory AuthFailure.fromRemoteDataSourceExceptionCode(String code) {
    final AuthFailureState state;
    switch (code) {
      case 'invalid-email':
        state = AuthFailureState.invalidEmail;
      case 'user-not-found':
        state = AuthFailureState.userNotFound;
      case 'wrong-password':
        state = AuthFailureState.wrongPassword;
      case 'email-already-in-use':
        state = AuthFailureState.emailAlreadyExists;
      case 'no-member':
        state = AuthFailureState.noMemberExists;
      default:
        state = AuthFailureState.unexpected;
    }
    return AuthFailure(state);
  }

  final AuthFailureState state;
}
