import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> registerMember(
      String studentNumber, String password);

  Future<Either<Failure, Unit>> sendEmailVerify(String studentNumber);
}
