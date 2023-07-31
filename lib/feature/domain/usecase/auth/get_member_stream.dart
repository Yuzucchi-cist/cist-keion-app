import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entity/auth/member.dart';
import '../../repository/auth_repository.dart';

class GetMemberStream {
  GetMemberStream({required this.authRepository});

  final AuthRepository authRepository;

  Stream<Either<Failure, Member?>> call(NoParams params) {
    return authRepository.getAuthChange();
  }
}
