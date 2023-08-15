import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entity/member_detail/member_detail.dart';
import '../../repository/member_detail_repository.dart';

class GetMemberDetailFromFile
    implements UseCase<({String fileName, List<MemberDetail> data}), NoParams> {
  GetMemberDetailFromFile({required this.memberDetailRepository});

  final MemberDetailRepository memberDetailRepository;

  @override
  Future<Either<Failure, ({String fileName, List<MemberDetail> data})>> call(
      NoParams params) {
    return memberDetailRepository.pickFromFile();
  }
}
