import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/suggestion_model.freezed.dart';
part 'generated/suggestion_model.g.dart';

@freezed
class SuggestionModel with _$SuggestionModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SuggestionModel({
    required String description,
    required String category,
    @TimestampConverter() Timestamp? createdAt,
  }) = _SuggestionModel;

  factory SuggestionModel.fromJson(Map<String, dynamic> json) =>
      _$SuggestionModelFromJson(json);
}

class TimestampConverter implements JsonConverter<Timestamp, Timestamp> {
  const TimestampConverter();

  @override
  Timestamp fromJson(Timestamp json) {
    return json;
  }

  @override
  Timestamp toJson(Timestamp timestamp) {
    return timestamp;
  }
}
