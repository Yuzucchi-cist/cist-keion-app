class FirebaseAuthException implements Exception {
  FirebaseAuthException(this.code);

  final String code;

  @override
  String toString() {
    return 'FirebaseAuthException: $code';
  }
}
