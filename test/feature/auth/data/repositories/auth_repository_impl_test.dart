import 'package:cist_keion_app/core/error/exception/firebase_auth_exception.dart';
import 'package:cist_keion_app/core/error/exception/firestore_exception.dart';
import 'package:cist_keion_app/core/error/failure/auth/auth_failure.dart';
import 'package:cist_keion_app/core/error/failure/auth/auth_failure_state.dart';
import 'package:cist_keion_app/core/error/failure/server/server_failure.dart';
import 'package:cist_keion_app/core/network/network_info.dart';
import 'package:cist_keion_app/feature/auth/data/datasources/remote/firebase_auth_data_source.dart';
import 'package:cist_keion_app/feature/auth/data/datasources/remote/firestore_data_source.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/firestore_user_model.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/institute_grade_model.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/user_state_model.dart';
import 'package:cist_keion_app/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([NetworkInfo, FirebaseAuthDataSource, FirestoreDataSource])
void main() {
  late AuthRepositoryImpl repository;
  late MockNetworkInfo mockNetworkInfo;
  late MockFirebaseAuthDataSource mockAuthDataSource;
  late MockFirestoreDataSource mockStoreDataSource;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockAuthDataSource = MockFirebaseAuthDataSource();
    mockStoreDataSource = MockFirestoreDataSource();
    repository = AuthRepositoryImpl(
        networkInfo: mockNetworkInfo,
        authDataSource: mockAuthDataSource,
        storeDataSource: mockStoreDataSource);
  });

  const tStudentNumber = 'b2202260';
  const tPassword = 'Cist1234';

  const tFirestoreUserModel = FirestoreUserModel(
      id: 'testId',
      studentNumber: 'b2202260',
      name: 'testName',
      instituteGrade: InstituteGradeModel.first,
      userState: UserStateModel.active,
      belongings: []);

  group('registerMember', () {
    test('should check online', () async {
      // arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);
      when(mockAuthDataSource.createUser(any, any))
          .thenAnswer((realInvocation) async {});
      when(mockStoreDataSource.getMemberByStudentNumber(any))
          .thenAnswer((realInvocation) async => tFirestoreUserModel);
      // act
      await repository.registerMember(tStudentNumber, tPassword);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() => when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true));

      test('should call create member', () async {
        // arrange
        when(mockAuthDataSource.createUser(any, any))
            .thenAnswer((realInvocation) async {});
        when(mockStoreDataSource.getMemberByStudentNumber(any))
            .thenAnswer((realInvocation) async => tFirestoreUserModel);
        // act
        final result =
            await repository.registerMember(tStudentNumber, tPassword);
        // assert
        verify(mockAuthDataSource.createUser(tStudentNumber, tPassword));
        expect(result, const Right(unit));
      });

      test('should return the auth failure when the auth datasource failed',
          () async {
        // arrange
        when(mockAuthDataSource.createUser(any, any))
            .thenThrow(FireAuthException('invalid-email'));
        when(mockStoreDataSource.getMemberByStudentNumber(any))
            .thenThrow(FirestoreException('no-member'));
        // act
        final result =
            await repository.registerMember(tStudentNumber, tPassword);
        expect(result, Left(AuthFailure(AuthFailureState.invalidEmail)));
      });

      test(
          'should return the auth failure when member does not exist in data base',
          () async {
        // arrange
        when(mockAuthDataSource.createUser(any, any))
            .thenAnswer((realInvocation) async {});
        when(mockStoreDataSource.getMemberByStudentNumber(any))
            .thenThrow(FirestoreException('no-member'));
        // act
        final result =
            await repository.registerMember(tStudentNumber, tPassword);
        // assert
        verify(mockStoreDataSource.getMemberByStudentNumber(tStudentNumber));
        verifyNever(mockAuthDataSource.createUser(any, any));
        expect(result, Left(AuthFailure(AuthFailureState.noMemberExists)));
      });
    });

    group('when device is offline', () {
      setUp(() => when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => false));
      test('should return the server failure', () async {
        // act
        final result =
            await repository.registerMember(tStudentNumber, tPassword);
        // assert
        expect(result, Left(ServerFailure()));
      });
    });
  });

  group('sendEmailVerify', () {
    test('should check online', () async {
      // arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);
      when(mockAuthDataSource.sendEmailVerify(any))
          .thenAnswer((realInvocation) async => {});
      // act
      await repository.sendEmailVerify(tStudentNumber);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() => when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true));
      test('should call data source to send email verify', () async {
        // arrange
        when(mockAuthDataSource.sendEmailVerify(any))
            .thenAnswer((realInvocation) async => {});
        // act
        final result = await repository.sendEmailVerify(tStudentNumber);
        // assert
        verify(mockAuthDataSource.sendEmailVerify(tStudentNumber));
        expect(result, const Right(unit));
      });

      test('should return auth failure when sending email failed', () async {
        // arrange
        when(mockAuthDataSource.sendEmailVerify(tStudentNumber))
            .thenThrow(FireAuthException('invalid-email'));
        // act
        final result = await repository.sendEmailVerify(tStudentNumber);
        // assert
        expect(result, Left(AuthFailure(AuthFailureState.invalidEmail)));
      });
    });

    group('device is offline', () {
      setUp(() => when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => false));

      test('should return server failure', () async {
        // act
        final result = await repository.sendEmailVerify(tStudentNumber);
        // assert
        verifyNever(mockAuthDataSource.sendEmailVerify(tStudentNumber));
        expect(result, Left(ServerFailure()));
      });
    });
  });
}
