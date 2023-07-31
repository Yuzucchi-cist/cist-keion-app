import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repository/auth_repository.dart';

class Logout implements UseCase<Unit, String> {
  Logout({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, Unit>> call(String studentNumber) {
    return authRepository.logout(studentNumber);
  }
}
