import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repository/auth_repository.dart';

class Logout implements UseCase<Unit, NoParams> {
  Logout({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return authRepository.logout();
  }
}
