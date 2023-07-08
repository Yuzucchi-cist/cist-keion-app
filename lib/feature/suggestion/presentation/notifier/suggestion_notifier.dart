import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/provider_di.dart';
import '../../domain/usecases/add_suggestion.dart';
import '../../domain/values/suggestion_category.dart';
import '../states/suggestion.dart';

final suggestionProvider =
    StateNotifierProvider<SuggestionNotifier, SuggestionState?>(
        (ref) => SuggestionNotifier(
              addSuggestion: ref.watch(addSuggestionProvider),
            ));

class SuggestionNotifier extends StateNotifier<SuggestionState?> {
  SuggestionNotifier({required this.addSuggestion}) : super(null);

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
    state = SuggestionState(description: description, category: category);
  }
}
