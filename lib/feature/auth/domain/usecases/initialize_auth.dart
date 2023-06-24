import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/member.dart';
import '../repositories/auth_repository.dart';

class InitializeAuth implements UseCase<Member, NoParams> {
  InitializeAuth({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, Member>> call(NoParams params) {
    return authRepository.getCurrentMember();
  }
}
