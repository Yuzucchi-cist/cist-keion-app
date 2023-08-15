import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entity/member_detail/member_detail.dart';
import '../../repository/member_detail_repository.dart';

class AddMemberDetailToDatabase
    implements UseCase<List<MemberDetail>, List<MemberDetail>> {
  AddMemberDetailToDatabase({required this.memberDetailRepository});

  final MemberDetailRepository memberDetailRepository;
  @override
  Future<Either<Failure, List<MemberDetail>>> call(
      List<MemberDetail> params) async {
    final result = await memberDetailRepository.getAll();
    return result.fold(
      (failure) {
        return Left(failure);
      },
      (memberDetailInDatabase) {
        final unduplicatedParams = params.toSet().toList();
        final memberStudentNumberInDatabase = memberDetailInDatabase
            .map((memberDetail) => memberDetail.studentNumber);
        unduplicatedParams.removeWhere((element) =>
            memberStudentNumberInDatabase.contains(element.studentNumber));
        if (unduplicatedParams.isEmpty) {
          return const Right([]);
        }
        return memberDetailRepository.addToDatabase(unduplicatedParams);
      },
    );
  }
}
