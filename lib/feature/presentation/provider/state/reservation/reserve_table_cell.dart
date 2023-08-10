// ignore_for_file: sort_unnamed_constructors_first

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entity/reservation/reservation.dart';

part 'generated/reserve_table_cell.freezed.dart';

@freezed
class ReserveTableCell with _$ReserveTableCell {
  const ReserveTableCell._();
  const factory ReserveTableCell(
      {required String title,
      String? id,
      String? reserveMemberId,
      String? reserveMemberName,
      @Default(false) bool isTapped}) = _ReserveTableCell;

  factory ReserveTableCell.fromReservation(Reservation reservation) =>
      ReserveTableCell(
          title: reservation.title,
          id: reservation.id,
          reserveMemberId: reservation.reservedMember.id,
          reserveMemberName: reservation.reservedMember.name);

  ReserveTableCell get resetReservation {
    return ReserveTableCell(title: '', isTapped: isTapped);
  }
}
