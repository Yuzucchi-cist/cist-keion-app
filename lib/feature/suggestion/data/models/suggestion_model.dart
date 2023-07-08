// ignore_for_file: sort_unnamed_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/suggestion_model.freezed.dart';
part 'generated/suggestion_model.g.dart';

@freezed
class SuggestionModel with _$SuggestionModel {
  const SuggestionModel._();
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SuggestionModel({
    required String id,
    required String description,
    required String category,
    @TimestampConverter() required Timestamp createdAt,
  }) = _SuggestionModel;

  factory SuggestionModel.fromJson(Map<String, dynamic> json) =>
      _$SuggestionModelFromJson(json);

  factory SuggestionModel.fromFirestoreJson(
      String id, Map<String, dynamic> json) {
    final convertedJson = {...json};
    convertedJson.addAll({'id': id});
    return SuggestionModel.fromJson(convertedJson);
  }

  Map<String, dynamic> get toFirestoreJson {
    final json = toJson();
    json.remove('id');
    return json;
  }
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
