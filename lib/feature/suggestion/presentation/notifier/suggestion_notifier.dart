import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/provider_di.dart';
import '../../domain/entities/suggestion.dart';
import '../../domain/usecases/add_suggestion.dart';
import '../../domain/values/suggestion_category.dart';

final suggestionProvider =
    StateNotifierProvider<SuggestionNotifier, Suggestion?>(
        (ref) => SuggestionNotifier(ref.watch(addSuggestionProvider)));

class SuggestionNotifier extends StateNotifier<Suggestion?> {
  SuggestionNotifier(this.addSuggestion) : super(null);

  final AddSuggestion addSuggestion;

  Future<void> add() async {
    if (state != null) {
      final params = AddSuggestionParams(
          description: state!.description, category: state!.category);
      addSuggestion(params);
    } else {
      throw Exception('ERROR: suggestion is null');
    }
  }

  void makeSuggestion(SuggestionCategory category, String description) {
    state = Suggestion(description: description, category: category);
  }
}
