import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/suggestion.dart';
import '../repositories/suggestion_repository.dart';

class GetSuggestions implements UseCase<List<Suggestion>, NoParams> {
  GetSuggestions({required this.suggestionRepository});

  final SuggestionRepository suggestionRepository;

  @override
  Future<Either<Failure, List<Suggestion>>> call(NoParams params) {
    return suggestionRepository.getAll();
  }
}
