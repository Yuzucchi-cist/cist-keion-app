import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/suggestion.dart';
import '../repositories/suggestion_repository.dart';
import '../values/suggestion_category.dart';

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
