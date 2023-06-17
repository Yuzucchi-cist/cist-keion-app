import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class RegisterMember extends UseCase<Unit, RegisterParams> {
  RegisterMember({required this.authRepository});

  final AuthRepository authRepository;
  @override
  Future<Either<Failure, Unit>> call(RegisterParams params) async {
    final result = await authRepository.registerMember(
        params.studentNumber, params.password);
    authRepository.sendEmailVerify(params.studentNumber);
    return result;
  }
}

class RegisterParams {
  RegisterParams({required this.studentNumber, required this.password});

  final String studentNumber;
  final String password;
}
