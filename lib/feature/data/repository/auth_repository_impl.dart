import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception/firebase_auth_exception.dart';
import '../../../core/error/exception/firestore_exception.dart';
import '../../../core/error/failure/auth/auth_failure.dart';
import '../../../core/error/failure/failure.dart';
import '../../../core/error/failure/server/server_failure.dart';
import '../../../core/network/network_info.dart';
import '../../domain/entity/auth/member.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/authentication_data_source.dart';
import '../datasource/member_detail_remote_data_source.dart';
import '../factory/auth/member_factory.dart';
import '../model/auth/authentication_user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.networkInfo,
    required this.authenticationDataSource,
    required this.memberDetailDataSource,
    required this.memberFactory,
  });

  final NetworkInfo networkInfo;
  final AuthenticationDataSource authenticationDataSource;
  final MemberDetailRemoteDataSource memberDetailDataSource;
  final MemberFactory memberFactory;

  @override
  Future<Either<Failure, Unit>> registerMember(
      String studentNumber, String password) async {
    if (await networkInfo.isConnected) {
      try {
        await memberDetailDataSource.getByStudentNumber(studentNumber);
        await authenticationDataSource.createUser(studentNumber, password);
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
        await authenticationDataSource.sendEmailVerify(studentNumber);
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
            authenticationDataSource.login(studentNumber, password));
  }

  @override
  Future<Either<Failure, Member>> getCurrentMember() async {
    return getMember(
        getAuthUserModel: () async =>
            authenticationDataSource.getCurrentUser());
  }

  Future<Either<Failure, Member>> getMember(
      {required Future<AuthenticationUserModel> Function()
          getAuthUserModel}) async {
    if (await networkInfo.isConnected) {
      try {
        final authUserModel = await getAuthUserModel();
        final storeUserModel = await memberDetailDataSource
            .getByStudentNumber(authUserModel.studentNumber);
        final member = memberFactory.createFromModel(Models(
            authUserModel: authUserModel, memberDetailModel: storeUserModel));
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

  @override
  Stream<Either<Failure, Member?>> getAuthChange() {
    try {
      return authenticationDataSource
          .getAuthStateChanges()
          .transform<Either<Failure, Member?>>(StreamTransformer.fromHandlers(
              handleData: (authModel, sink) async {
            if (authModel == null) {
              sink.add(const Right(null));
            } else {
              try {
                final storeModel = await memberDetailDataSource
                    .getByStudentNumber(authModel.studentNumber);
                sink.add(Right<Failure, Member>(memberFactory.createFromModel(
                    Models(
                        authUserModel: authModel,
                        memberDetailModel: storeModel))));
              } on FirestoreException catch (e) {
                sink.add(Left(
                    AuthFailure.fromRemoteDataSourceExceptionCode(e.code)));
              }
            }
          }, handleError: (error, stackTrace, sink) {
            if (error is FireAuthException) {
              sink.add(Left(
                  AuthFailure.fromRemoteDataSourceExceptionCode(error.code)));
            } else if (error is Exception) {
              throw error;
            }
            throw Exception(error);
          }));
    } on FireAuthException catch (e) {
      return Stream.value(
          Left(AuthFailure.fromRemoteDataSourceExceptionCode(e.code)));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        authenticationDataSource.logout();
        return const Right(unit);
      } on FireAuthException catch (e) {
        return Left(AuthFailure.fromRemoteDataSourceExceptionCode(e.code));
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
