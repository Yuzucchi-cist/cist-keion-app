enum InstituteTime {
  first('1講'),
  second('2講'),
  noon('昼休み'),
  third('3講'),
  forth('4講'),
  fifth('5講'),
  afterSchool('放課後');

  final String value;
  // ignore: sort_constructors_first
  const InstituteTime(this.value);
}
