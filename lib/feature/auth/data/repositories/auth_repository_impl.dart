import 'package:dartz/dartz.dart';

import '../../../../core/error/exception/firebase_auth_exception.dart';
import '../../../../core/error/exception/firestore_exception.dart';
import '../../../../core/error/failure/auth/auth_failure.dart';
import '../../../../core/error/failure/failure.dart';
import '../../../../core/error/failure/server/server_failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/member.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/firebase_auth_data_source.dart';
import '../datasources/remote/firestore_data_source.dart';
import '../factories/member_factory.dart';
import '../models/firebase_auth/firebase_auth_user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.networkInfo,
    required this.authDataSource,
    required this.storeDataSource,
    required this.memberFactory,
  });

  final NetworkInfo networkInfo;
  final FirebaseAuthDataSource authDataSource;
  final FirestoreDataSource storeDataSource;
  final MemberFactory memberFactory;

  @override
  Future<Either<Failure, Unit>> registerMember(
      String studentNumber, String password) async {
    if (await networkInfo.isConnected) {
      try {
        await storeDataSource.getMemberByStudentNumber(studentNumber);
        await authDataSource.createUser(studentNumber, password);
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
        await authDataSource.sendEmailVerify(studentNumber);
        return const Right(unit);
      } on FireAuthException catch (e) {
        return Left(AuthFailure.fromRemoteDataSourceExceptionCode(e.code));
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Member>> login(
      String studentNumber, String password) async {
    return getMember(
        getAuthUserModel: () async =>
            authDataSource.login(studentNumber, password));
  }

  @override
  Future<Either<Failure, Member>> getCurrentMember() async {
    return getMember(
        getAuthUserModel: () async => authDataSource.getCurrentUser());
  }

  Future<Either<Failure, Member>> getMember(
      {required Future<FirebaseAuthUserModel> Function()
          getAuthUserModel}) async {
    if (await networkInfo.isConnected) {
      try {
        final authUserModel = await getAuthUserModel();
        final storeUserModel = await storeDataSource
            .getMemberByStudentNumber(authUserModel.studentNumber);
        final member = memberFactory.createFromModel(Models(
            authUserModel: authUserModel, storeUserModel: storeUserModel));
        return Right(member);
      } on FireAuthException catch (e) {
        return Left(AuthFailure.fromRemoteDataSourceExceptionCode(e.code));
      } on FirestoreException catch (e) {
        return Left(AuthFailure.fromRemoteDataSourceExceptionCode(e.code));
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
