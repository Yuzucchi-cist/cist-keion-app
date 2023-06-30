import 'package:freezed_annotation/freezed_annotation.dart';

import '../values/institute_time.dart';
import '../values/reserved_member.dart';

part 'generated/reservation.freezed.dart';

@freezed
class Reservation with _$Reservation {
  const factory Reservation({
    required String id,
    required String title,
    required DateTime date,
    required ReservedMember reservedMember,
    required InstituteTime time,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Reservation;
}
