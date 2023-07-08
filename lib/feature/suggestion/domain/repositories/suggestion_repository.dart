import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../entities/suggestion.dart';

abstract class SuggestionRepository {
  Future<Either<Failure, Unit>> add(Suggestion suggestion);
  Future<Either<Failure, List<Suggestion>>> getAll();
}
