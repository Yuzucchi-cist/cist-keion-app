import 'package:dartz/dartz.dart';

import '../../../core/error/exception/picking_file_exception.dart';
import '../../../core/error/failure/failure.dart';
import '../../../core/error/failure/member_detail/member_detail_failure.dart';
import '../../domain/entity/member_detail/member_detail.dart';
import '../../domain/repository/member_detail_repository.dart';
import '../datasource/member_detail_local_data_source.dart';
import '../factory/member_detail/member_detail_factory.dart';

class MemberDetailRepositoryImpl implements MemberDetailRepository {
  MemberDetailRepositoryImpl(
      {required this.memberDetailLLocalDataSource,
      required this.memberDetailFactory});

  final MemberDetailLocalDataSource memberDetailLLocalDataSource;
  final MemberDetailFactory memberDetailFactory;

  @override
  Future<Either<Failure, Unit>> addToDatabase(
      List<MemberDetail> memberDetailList) {
    // TODO(yuzucchi): implement addToDatabase
    throw UnimplementedError();
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
