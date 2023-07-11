import '../../utils/firebase_auth_error_handring.dart';

const String errorCodeUserNotLoggedIn = 'user-not-logged-in';

class FireAuthException implements Exception {
  // TODO(yuzucchi): firebaseのエラーハンドリングバグが修正されたら以下に修正
  // FireAuthException(this.code);
  FireAuthException(String? status)
      : code = parseFirebaseAuthExceptionMessage(input: status);

  final String code;

  @override
  String toString() {
    return 'FirebaseAuthException: $code';
  }
}
