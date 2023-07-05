import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/values/suggestion_category.dart';

part 'generated/suggestion.freezed.dart';

@freezed
class Suggestion with _$Suggestion {
  const factory Suggestion({
    required SuggestionCategory category,
    required String description,
  }) = _Suggestion;
}
