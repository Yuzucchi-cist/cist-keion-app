import 'package:clock/clock.dart';

DateTime getStartDateOfThisWeek() {
  final now = clock.now();
  final today = DateTime(now.year, now.month, now.day);
  return today.subtract(Duration(days: today.weekday % 7));
}
