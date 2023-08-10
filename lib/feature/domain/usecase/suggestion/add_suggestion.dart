import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entity/suggestion/suggestion.dart';
import '../../repository/suggestion_repository.dart';
import '../../value/suggestion_category.dart';

class AddSuggestion implements UseCase<Unit, AddSuggestionParams> {
  AddSuggestion({required this.suggestionRepository});

  final SuggestionRepository suggestionRepository;

  @override
  Future<Either<Failure, Unit>> call(AddSuggestionParams params) {
    return suggestionRepository.add(Suggestion(
        id: '', description: params.description, category: params.category));
  }
}

class AddSuggestionParams {
  AddSuggestionParams({required this.description, required this.category});

  final String description;
  final SuggestionCategory category;
}
