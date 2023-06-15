import 'package:dartz/dartz.dart';

import '../../../../core/error/exception/firebase_auth_exception.dart';
import '../../../../core/error/exception/firestore_exception.dart';
import '../../../../core/error/failure/auth/auth_failure.dart';
import '../../../../core/error/failure/failure.dart';
import '../../../../core/error/failure/server/server_failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/firebase_auth_data_source.dart';
import '../datasources/remote/firestore_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
      {required this.networkInfo,
      required this.authDataSource,
      required this.storeDataSource});

  final NetworkInfo networkInfo;
  final FirebaseAuthDataSource authDataSource;
  final FirestoreDataSource storeDataSource;

  @override
  Future<Either<Failure, Unit>> registerMember(
      String studentNumber, String password) async {
    if (await networkInfo.isConnected) {
      try {
        storeDataSource.getMemberByStudentNumber(studentNumber);
        authDataSource.createUser(studentNumber, password);
        return const Right(unit);
      } on FireAuthException catch (e) {
        return Left(AuthFailure.fromRemoteDataSourceExceptionCode(e.code));
      } on FirestoreException catch (e) {
        return Left(AuthFailure.fromRemoteDataSourceExceptionCode(e.code));
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> sendEmailVerify(String studentNumber) async {
    if (await networkInfo.isConnected) {
      try {
        authDataSource.sendEmailVerify(studentNumber);
        return const Right(unit);
      } on FireAuthException catch (e) {
        return Left(AuthFailure.fromRemoteDataSourceExceptionCode(e.code));
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
