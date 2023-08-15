import 'package:dartz/dartz.dart';

import '../../../core/error/exception/firestore_exception.dart';
import '../../../core/error/exception/picking_file_exception.dart';
import '../../../core/error/failure/failure.dart';
import '../../../core/error/failure/member_detail/member_detail_failure.dart';
import '../../../core/error/failure/remote_data/remote_data_failure.dart';
import '../../../core/error/failure/server/server_failure.dart';
import '../../../core/network/network_info.dart';
import '../../domain/entity/member_detail/member_detail.dart';
import '../../domain/repository/member_detail_repository.dart';
import '../datasource/member_detail_local_data_source.dart';
import '../datasource/member_detail_remote_data_source.dart';
import '../factory/member_detail/member_detail_factory.dart';

class MemberDetailRepositoryImpl implements MemberDetailRepository {
  MemberDetailRepositoryImpl({
    required this.networkInfo,
    required this.memberDetailLLocalDataSource,
    required this.memberDetailRemoteDataSource,
    required this.memberDetailFactory,
  });

  final NetworkInfo networkInfo;
  final MemberDetailLocalDataSource memberDetailLLocalDataSource;
  final MemberDetailRemoteDataSource memberDetailRemoteDataSource;
  final MemberDetailFactory memberDetailFactory;

  @override
  Future<Either<Failure, List<MemberDetail>>> addToDatabase(
      List<MemberDetail> memberDetailList) async {
    if (await networkInfo.isConnected) {
      final modelList = memberDetailList
          .map((memberDetail) =>
              memberDetailFactory.convertToModel(memberDetail))
          .toList();
      try {
        final result = await memberDetailRemoteDataSource.add(modelList);
        final addedMemberDetail = result
            .map((model) => memberDetailFactory.createFromModel(model))
            .toList();
        return Right(addedMemberDetail);
      } on FirestoreException catch (e) {
        return Left(RemoteDataFailure.fromExceptionCode(e.code));
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MemberDetail>>> getAll() async {
    if (await networkInfo.isConnected) {
      try {
        final models = await memberDetailRemoteDataSource.getAll();
        final memberDetailList = models
            .map((model) => memberDetailFactory.createFromModel(model))
            .toList();
        return Right(memberDetailList);
      } on FirestoreException catch (e) {
        return Left(RemoteDataFailure.fromExceptionCode(e.code));
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ({String fileName, List<MemberDetail> data})>>
      pickFromFile() async {
    try {
      final (fileName, models) =
          await memberDetailLLocalDataSource.pickFromLocalFile();
      final memberDetailList = models
          .map((model) => memberDetailFactory.createFromModel(model))
          .toList();
      return Right((fileName: fileName, data: memberDetailList));
    } on PickingFileException catch (e) {
      return Left(MemberDetailFailure.fromDataSourceExceptionCode(e.code));
    }
  }
}
