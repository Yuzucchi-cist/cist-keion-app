import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/reserved_member_model.freezed.dart';
part 'generated/reserved_member_model.g.dart';

@freezed
class ReservedMemberModel with _$ReservedMemberModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ReservedMemberModel({
    required String id,
    required String name,
  }) = _ReservedMemberModel;

  factory ReservedMemberModel.fromJson(Map<String, dynamic> json) =>
      _$ReservedMemberModelFromJson(json);
}
