import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum InstituteGradeModel {
  first,
  second,
  third,
  forth,
  other;
}
