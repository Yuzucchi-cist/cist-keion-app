import 'package:dartz/dartz.dart';

import '../../../../core/error/exception/firestore_exception.dart';
import '../../../../core/error/failure/failure.dart';
import '../../../../core/error/failure/server/server_failure.dart';
import '../../../../core/error/failure/suggetion/suggestion_failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/suggestion.dart';
import '../../domain/repositories/suggestion_repository.dart';
import '../datasources/suggestion_remote_data_source.dart';
import '../factories/suggestion_factory.dart';

class SuggestionRepositoryImpl implements SuggestionRepository {
  SuggestionRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.suggestionFactory,
  });

  final SuggestionRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final SuggestionFactory suggestionFactory;

  @override
  Future<Either<Failure, Unit>> add(Suggestion suggestion) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource
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
        final suggestionModel = await remoteDataSource.getAll();
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
