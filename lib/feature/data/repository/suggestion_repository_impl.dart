import 'package:dartz/dartz.dart';

import '../../../core/error/exception/firestore_exception.dart';
import '../../../core/error/failure/failure.dart';
import '../../../core/error/failure/server/server_failure.dart';
import '../../../core/error/failure/suggestion/suggestion_failure.dart';
import '../../../core/network/network_info.dart';
import '../../domain/entity/suggestion/suggestion.dart';
import '../../domain/repository/suggestion_repository.dart';
import '../datasource/suggestion_data_source.dart';
import '../factory/suggestion/suggestion_factory.dart';

class SuggestionRepositoryImpl implements SuggestionRepository {
  SuggestionRepositoryImpl({
    required this.suggestionDataSource,
    required this.networkInfo,
    required this.suggestionFactory,
  });

  final SuggestionDataSource suggestionDataSource;
  final NetworkInfo networkInfo;
  final SuggestionFactory suggestionFactory;

  @override
  Future<Either<Failure, Unit>> add(Suggestion suggestion) async {
    if (await networkInfo.isConnected) {
      try {
        await suggestionDataSource
            .add(suggestionFactory.convertToModel(suggestion));
        return const Right(unit);
      } on FirestoreException catch (e) {
        return Left(SuggestionFailure.fromCode(e.code));
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Suggestion>>> getAll() async {
    if (await networkInfo.isConnected) {
      try {
        final suggestionModel = await suggestionDataSource.getAll();
        return Right(suggestionModel
            .map((model) => suggestionFactory.createFromModel(model))
            .toList());
      } on FirestoreException catch (e) {
        return Left(SuggestionFailure.fromCode(e.code));
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
