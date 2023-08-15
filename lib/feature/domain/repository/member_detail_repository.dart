import 'package:dartz/dartz.dart';

import '../../../core/error/failure/failure.dart';
import '../entity/member_detail/member_detail.dart';

abstract class MemberDetailRepository {
  Future<Either<Failure, ({String fileName, List<MemberDetail> data})>>
      pickFromFile();
  Future<Either<Failure, List<MemberDetail>>> addToDatabase(
      List<MemberDetail> memberDetailList);
  Future<Either<Failure, List<MemberDetail>>> getAll();
}
