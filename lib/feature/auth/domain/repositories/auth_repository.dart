import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> registerMember(
      String studentNumber, String password);
}
