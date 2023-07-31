import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entity/auth/member.dart';
import '../../repository/auth_repository.dart';

class Login implements UseCase<Member, LoginParams> {
  Login({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, Member>> call(LoginParams params) async {
    return authRepository.login(params.studentNumber, params.password);
  }
}

class LoginParams {
  LoginParams({required this.studentNumber, required this.password});

  final String studentNumber;
  final String password;
}
