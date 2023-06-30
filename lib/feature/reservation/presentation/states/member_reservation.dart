import '../../domain/entities/reservation.dart';
import '../../domain/values/institute_time.dart';
import 'week_day.dart';

class MemberReservation {
  MemberReservation({required Reservation reservation, this.isChecked = false})
      : id = reservation.id,
        title = reservation.title,
        date = reservation.date,
        time = reservation.time,
        reservedMemberId = reservation.reservedMember.id;

  final String id;
  final String title;
  final DateTime date;
  final InstituteTime time;
  final String reservedMemberId;
  bool isChecked;

  String get params {
    return '$title ${date.year}年${date.month}月${date.day}(${WeekDay.fromDate(date).value}) ${time.value}';
  }
}
