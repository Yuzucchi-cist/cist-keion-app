class PickingFileException implements Exception {
  PickingFileException({
    required this.code,
    required this.message,
  });

  final String code;
  final String message;
}
