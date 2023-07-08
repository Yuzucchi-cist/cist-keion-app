import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/error/failure/server/server_failure.dart';
import '../../../../core/error/failure/suggetion/suggestion_failure.dart';
import '../../../../core/error/failure/suggetion/suggestion_failure_state.dart';
import '../../../../core/provider_di.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/suggestion.dart';
import '../../domain/usecases/get_suggestions.dart';

final suggestionListProvider =
    StateNotifierProvider<SuggestionListNotifier, List<Suggestion>>((ref) =>
        SuggestionListNotifier(
            getSuggestions: ref.watch(getSuggestionsProvider)));

class SuggestionListNotifier extends StateNotifier<List<Suggestion>> {
  SuggestionListNotifier({required this.getSuggestions}) : super([]);

  final GetSuggestions getSuggestions;

  Future<List<Suggestion>> getAll() async {
    final result = await getSuggestions(NoParams());
    final suggestions = result.fold<List<Suggestion>>(
      (failure) {
        if (failure is ServerFailure) {
          throw Exception(failure);
        } else if (failure is SuggestionFailure) {
          switch (failure.state) {
            case SuggestionFailureState.noData:
              return [];
            case SuggestionFailureState.unexpected:
              throw Exception('Unexpected Error');
          }
        }
        return [];
      },
      (suggestions) => suggestions,
    );

    state = suggestions;
    return suggestions;
  }

  Suggestion getById(String id) {
    return state.firstWhere((suggestion) => suggestion.id == id);
  }
}
