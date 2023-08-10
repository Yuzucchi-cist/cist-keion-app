import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/value/suggestion_category.dart';

part 'generated/suggestion.freezed.dart';

@freezed
class SuggestionState with _$SuggestionState {
  const factory SuggestionState({
    required SuggestionCategory category,
    required String description,
  }) = _SuggestionState;
}
