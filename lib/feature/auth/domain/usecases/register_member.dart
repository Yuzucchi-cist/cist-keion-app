import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class RegisterMember extends UseCase<Unit, Params> {
  RegisterMember({required this.authRepository});

  final AuthRepository authRepository;
  @override
  Future<Either<Failure, Unit>> call(Params params) {
    return authRepository
        .registerMember(params.studentNumber, params.password)
        .then((_) => authRepository.sendEmailVerify(params.studentNumber));
  }
}

class Params {
  Params({required this.studentNumber, required this.password});

  final String studentNumber;
  final String password;
}
