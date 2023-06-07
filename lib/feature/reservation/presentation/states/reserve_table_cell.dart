import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/reserve_table_cell.freezed.dart';

@freezed
class ReserveTableCell with _$ReserveTableCell {
  const factory ReserveTableCell(
      {required String title,
      @Default(false) bool isTapped}) = _ReserveTableCell;
}
