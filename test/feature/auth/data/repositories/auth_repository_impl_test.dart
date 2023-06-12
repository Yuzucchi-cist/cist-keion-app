import 'package:cist_keion_app/core/error/exception/firebase_auth_exception.dart';
import 'package:cist_keion_app/core/error/exception/firestore_exception.dart';
import 'package:cist_keion_app/core/error/failure/auth/auth_failure.dart';
import 'package:cist_keion_app/core/error/failure/auth/auth_failure_state.dart';
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

@GenerateMocks([FirebaseAuthDataSource, FirestoreDataSource])
void main() {
  late AuthRepositoryImpl repository;
  late MockFirebaseAuthDataSource mockAuthDataSource;
  late MockFirestoreDataSource mockStoreDataSource;

  setUp(() {
    mockAuthDataSource = MockFirebaseAuthDataSource();
    mockStoreDataSource = MockFirestoreDataSource();
    repository = AuthRepositoryImpl(
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
    test('should call create member', () async {
      // arrange
      when(mockAuthDataSource.createUser(any, any))
          .thenAnswer((realInvocation) async {});
      when(mockStoreDataSource.getMemberByStudentNumber(any))
          .thenAnswer((realInvocation) async => tFirestoreUserModel);
      // act
      final result = await repository.registerMember(tStudentNumber, tPassword);
      // assert
      verify(mockAuthDataSource.createUser(tStudentNumber, tPassword));
      expect(result, const Right(unit));
    });

    test('should return the auth failure when the auth datasource failed',
        () async {
      // arrange
      when(mockAuthDataSource.createUser(any, any))
          .thenThrow(FirebaseAuthException('invalid-email'));
      when(mockStoreDataSource.getMemberByStudentNumber(any))
          .thenThrow(FirestoreException('no-member'));
      // act
      final result = await repository.registerMember(tStudentNumber, tPassword);
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
      final result = await repository.registerMember(tStudentNumber, tPassword);
      // assert
      verify(mockStoreDataSource.getMemberByStudentNumber(tStudentNumber));
      verifyNever(mockAuthDataSource.createUser(any, any));
      expect(result, Left(AuthFailure(AuthFailureState.noMemberExists)));
    });
  });
}
