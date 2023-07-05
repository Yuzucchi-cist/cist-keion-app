import 'package:freezed_annotation/freezed_annotation.dart';

import '../values/suggestion_category.dart';

part 'generated/suggestion.freezed.dart';

@freezed
class Suggestion with _$Suggestion {
  const factory Suggestion({
    required String description,
    required SuggestionCategory category,
    DateTime? createdAt,
  }) = _Suggestion;
}
