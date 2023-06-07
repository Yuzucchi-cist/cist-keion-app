enum WeekDay {
  sun('日'),
  mon('月'),
  tue('火'),
  wed('水'),
  thu('木'),
  fri('金'),
  str('土');

  final String value;

  // ignore: sort_constructors_first
  const WeekDay(this.value);

  // ignore: sort_constructors_first
  factory WeekDay.fromDate(DateTime date) {
    return WeekDay.values[(date.weekday % DateTime.daysPerWeek)];
  }

  DateTime get date {
    final today = DateTime.now();
    return today.subtract(Duration(days: (today.weekday % 7) - index));
  }
}
