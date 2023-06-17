import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/member.dart';
import '../repositories/auth_repository.dart';

class Login implements UseCase<Member, Params> {
  Login({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, Member>> call(Params params) async {
    return authRepository.login(params.studentNumber, params.password);
  }
}

class Params {
  Params({required this.studentNumber, required this.password});

  final String studentNumber;
  final String password;
}
