import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum UserStateModel {
  active,
  sleep,
  quited,
}
