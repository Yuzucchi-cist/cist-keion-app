class FireAuthException implements Exception {
  FireAuthException(this.code);

  final String code;

  @override
  String toString() {
    return 'FirebaseAuthException: $code';
  }
}
