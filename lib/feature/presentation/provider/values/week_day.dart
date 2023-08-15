// ignore_for_file: sort_constructors_first

enum WeekDay {
  sun('日'),
  mon('月'),
  tue('火'),
  wed('水'),
  thu('木'),
  fri('金'),
  str('土');

  final String value;

  const WeekDay(this.value);

  factory WeekDay.fromDate(DateTime date) {
    return WeekDay.values[(date.weekday % DateTime.daysPerWeek)];
  }

  DateTime date(DateTime startDateOfWeek) {
    return startDateOfWeek.add(Duration(days: index));
  }
}
