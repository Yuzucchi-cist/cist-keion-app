String parseFirebaseAuthExceptionMessage(
    {String plugin = 'auth', required String? input}) {
  if (input == null) {
    return 'unknown';
  }

  // https://regexr.com/7en3h
  final regexPattern = r'(?<=\(' + plugin + r'/)(.*?)(?=\)\.)';
  final regExp = RegExp(regexPattern);
  final match = regExp.firstMatch(input);
  if (match != null) {
    return match.group(0)!;
  }

  return 'unknown';
}
