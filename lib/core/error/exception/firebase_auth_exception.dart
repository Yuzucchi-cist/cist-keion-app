import '../../utils/firebase_auth_error_handring.dart';

const String errorCodeUserNotLoggedIn = 'user-not-logged-in';

class FireAuthException implements Exception {
  // TODO(yuzucchi): firebaseのエラーハンドリングバグが修正されたら以下に修正
  FireAuthException(this.code);

  FireAuthException.fromMessage(String? message)
      : code = parseFirebaseAuthExceptionMessage(input: message);

  final String code;

  @override
  String toString() {
    return 'FirebaseAuthException: $code';
  }
}
