import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/error/failure/server/server_failure.dart';
import '../../../../../core/error/failure/suggestion/suggestion_failure.dart';
import '../../../../../core/error/failure/suggestion/suggestion_failure_state.dart';
import '../../../../../core/provider_di.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../domain/entity/suggestion/suggestion.dart';

final suggestionListProvider =
    AsyncNotifierProvider<SuggestionListNotifier, List<Suggestion>>(
        () => SuggestionListNotifier());

class SuggestionListNotifier extends AsyncNotifier<List<Suggestion>> {
  SuggestionListNotifier();

  @override
  FutureOr<List<Suggestion>> build() async {
    final result = await ref.read(getSuggestionsProvider)(NoParams());
    return result.fold(
      (failure) {
        if (failure is ServerFailure) {
          throw Exception('$failure');
        } else if (failure is SuggestionFailure) {
          switch (failure.state) {
            case SuggestionFailureState.noData:
              return [];
            case SuggestionFailureState.unexpected:
              throw Exception('Unexpected Error');
          }
        }
        throw Exception('Unexpected Error');
      },
      (suggestions) => suggestions,
    );
  }

  Future<AsyncValue<List<Suggestion>>> getAll() async {
    final result = await ref.read(getSuggestionsProvider)(NoParams());
    result.fold(
      (failure) {
        if (failure is ServerFailure) {
          state = AsyncError(failure, StackTrace.current);
        } else if (failure is SuggestionFailure) {
          switch (failure.state) {
            case SuggestionFailureState.noData:
              state = const AsyncData([]);
            case SuggestionFailureState.unexpected:
              state = AsyncError('Unexpected Error', StackTrace.current);
          }
        }
        state = AsyncError('Unexpected Error', StackTrace.current);
      },
      (suggestions) => state = AsyncData(suggestions),
    );
    return state;
  }

  Future<AsyncValue<Suggestion>> getById(String id) async {
    if (state.value?.isEmpty ?? true) {
      await getAll();
    }
    return state.whenData((suggestionList) =>
        suggestionList.firstWhere((suggestion) => suggestion.id == id));
  }
}
