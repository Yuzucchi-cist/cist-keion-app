import 'package:dartz/dartz.dart';

import '../../../../core/error/failure/failure.dart';
import '../entities/member.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> registerMember(
      String studentNumber, String password);

  Future<Either<Failure, Member>> login(String studentNumber, String password);

  Future<Either<Failure, Unit>> sendEmailVerify(String studentNumber);

  Future<Either<Failure, Member>> getCurrentMember();

  Stream<Either<Failure, Member>> getAuthChange();
}
