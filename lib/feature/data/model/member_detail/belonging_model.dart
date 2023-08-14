import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/belonging_model.freezed.dart';
part 'generated/belonging_model.g.dart';

@freezed
class BelongingModel with _$BelongingModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory BelongingModel({
    required String id,
    required BelongingType type,
    required String name,
  }) = _BelongingModel;

  factory BelongingModel.fromJson(Map<String, dynamic> json) =>
      _$BelongingModelFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.snake)
enum BelongingType {
  band,
  unexpected,
}
