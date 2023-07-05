import '../failure.dart';
import 'suggestion_failure_state.dart';

class SuggestionFailure extends Failure {
  SuggestionFailure([this.state = SuggestionFailureState.unexpected])
      : super([state]);

  factory SuggestionFailure.fromCode(String code) {
    late SuggestionFailureState state;
    switch (code) {
      case 'no-data':
        state = SuggestionFailureState.noData;
      default:
        state = SuggestionFailureState.unexpected;
    }
    return SuggestionFailure(state);
  }

  final SuggestionFailureState state;
}
