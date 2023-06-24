class FirestoreException implements Exception {
  FirestoreException(this.code);

  final String code;

  @override
  String toString() {
    return 'FirestoreException: $code';
  }
}
