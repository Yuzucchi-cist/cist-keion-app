import 'package:cist_keion_app/core/error/exception/firebase_auth_exception.dart';
import 'package:cist_keion_app/core/error/exception/firestore_exception.dart';
import 'package:cist_keion_app/core/error/failure/auth/auth_failure.dart';
import 'package:cist_keion_app/core/error/failure/auth/auth_failure_state.dart';
import 'package:cist_keion_app/core/error/failure/failure.dart';
import 'package:cist_keion_app/core/error/failure/server/server_failure.dart';
import 'package:cist_keion_app/core/network/network_info.dart';
import 'package:cist_keion_app/feature/auth/data/datasources/remote/firebase_auth_data_source.dart';
import 'package:cist_keion_app/feature/auth/data/datasources/remote/firestore_data_source.dart';
import 'package:cist_keion_app/feature/auth/data/factories/member_factory.dart';
import 'package:cist_keion_app/feature/auth/data/models/firebase_auth/firebase_auth_user_model.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/firestore_user_model.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/institute_grade_model.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/user_state_model.dart';
import 'package:cist_keion_app/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:cist_keion_app/feature/auth/domain/entities/member.dart';
import 'package:cist_keion_app/feature/auth/domain/values/institute_grade.dart';
import 'package:cist_keion_app/feature/auth/domain/values/user_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks(
    [NetworkInfo, FirebaseAuthDataSource, FirestoreDataSource, MemberFactory])
void main() {
  late AuthRepositoryImpl repository;
  late MockNetworkInfo mockNetworkInfo;
  late MockFirebaseAuthDataSource mockAuthDataSource;
  late MockFirestoreDataSource mockStoreDataSource;
  late MockMemberFactory mockMemberFactory;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockAuthDataSource = MockFirebaseAuthDataSource();
    mockStoreDataSource = MockFirestoreDataSource();
    mockMemberFactory = MockMemberFactory();
    repository = AuthRepositoryImpl(
      networkInfo: mockNetworkInfo,
      authDataSource: mockAuthDataSource,
      storeDataSource: mockStoreDataSource,
      memberFactory: mockMemberFactory,
    );
  });

  void checkOnline(
      {required void Function() arrange, required void Function() act}) {
    test('should check online', () async {
      // arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);
      arrange();
      // act
      act();
      // assert
      verify(mockNetworkInfo.isConnected);
    });
  }

  void returnServerFailureWhenDeviceIsOffline(
      {required Future<Either<Failure, dynamic>> Function() act}) {
    group('when device is offline', () {
      setUp(() => when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => false));
      test('should return the server failure', () async {
        // act
        final result = await act();
        // assert
        expect(result, Left(ServerFailure()));
      });
    });
  }

  const tStudentNumber = 'b2202260';
  const tPassword = 'Cist1234';

  const tAuthUserModel = FirebaseAuthUserModel(
      email: tStudentNumber + emailDomainOfInstitute,
      studentNumber: tStudentNumber,
      isEmailVerify: false);

  const tFirestoreUserModel = FirestoreUserModel(
      id: 'testId',
      studentNumber: 'b2202260',
      name: 'testName',
      instituteGrade: InstituteGradeModel.first,
      userState: UserStateModel.active,
      belongings: []);

  const tModels = Models(
      authUserModel: tAuthUserModel, storeUserModel: tFirestoreUserModel);

  const tMember = Member(
      memberId: 'testId',
      studentNumber: tStudentNumber,
      name: 'testName',
      instituteGrade: InstituteGrade.first,
      userState: UserState.active,
      isVerified: false);

  group('registerMember', () {
    checkOnline(
      arrange: () {
        when(mockAuthDataSource.createUser(any, any))
            .thenAnswer((realInvocation) async {});
        when(mockStoreDataSource.getMemberByStudentNumber(any))
            .thenAnswer((realInvocation) async => tFirestoreUserModel);
      },
      act: () async {
        await repository.registerMember(tStudentNumber, tPassword);
      },
    );

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

    returnServerFailureWhenDeviceIsOffline(
        act: () => repository.registerMember(tStudentNumber, tPassword));
  });

  group('sendEmailVerify', () {
    checkOnline(
      arrange: () {
        when(mockAuthDataSource.sendEmailVerify(any))
            .thenAnswer((realInvocation) async => {});
      },
      act: () async {
        await repository.sendEmailVerify(tStudentNumber);
      },
    );

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

    returnServerFailureWhenDeviceIsOffline(
        act: () => repository.sendEmailVerify(tStudentNumber));
  });

  group('login', () {
    checkOnline(
      arrange: () {
        when(mockAuthDataSource.login(any, any))
            .thenAnswer((realInvocation) async => tAuthUserModel);
        when(mockStoreDataSource.getMemberByStudentNumber(any))
            .thenAnswer((realInvocation) async => tFirestoreUserModel);
        when(mockMemberFactory.createFromModel(any)).thenReturn(tMember);
      },
      act: () async {
        await repository.login(tStudentNumber, tPassword);
      },
    );

    group('device is online', () {
      setUp(() => when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true));

      test('should return member when data sources are successful', () async {
        // arrange
        when(mockAuthDataSource.login(any, any))
            .thenAnswer((realInvocation) async => tAuthUserModel);
        when(mockStoreDataSource.getMemberByStudentNumber(any))
            .thenAnswer((realInvocation) async => tFirestoreUserModel);
        when(mockMemberFactory.createFromModel(any)).thenReturn(tMember);
        // act
        final result = await repository.login(tStudentNumber, tPassword);
        // assert
        verify(mockAuthDataSource.login(tStudentNumber, tPassword));
        verify(mockStoreDataSource.getMemberByStudentNumber(tStudentNumber));
        expect(result, const Right(tMember));
      });

      test('should call factory to convert model', () async {
        // arrange
        when(mockAuthDataSource.login(any, any))
            .thenAnswer((realInvocation) async => tAuthUserModel);
        when(mockStoreDataSource.getMemberByStudentNumber(any))
            .thenAnswer((realInvocation) async => tFirestoreUserModel);
        when(mockMemberFactory.createFromModel(any)).thenReturn(tMember);
        // act
        final result = await repository.login(tStudentNumber, tPassword);
        // assert
        verify(mockMemberFactory.createFromModel(tModels));
        expect(result, const Right(tMember));
      });

      test('should return auth failure when auth data source failed', () async {
        // arrange
        when(mockAuthDataSource.login(any, any))
            .thenThrow(FireAuthException('invalid-email'));
        // act
        final result = await repository.login(tStudentNumber, tPassword);
        // assert
        verifyNever(mockStoreDataSource.getMemberByStudentNumber(any));
        verifyNever(mockMemberFactory.createFromModel(any));
        expect(result, Left(AuthFailure(AuthFailureState.invalidEmail)));
      });

      test(
          'should return the auth failure when member does not exist in data base',
          () async {
        // arrange
        when(mockAuthDataSource.login(any, any))
            .thenAnswer((realInvocation) async => tAuthUserModel);
        when(mockStoreDataSource.getMemberByStudentNumber(any))
            .thenThrow(FirestoreException('no-member'));
        // act
        final result = await repository.login(tStudentNumber, tPassword);
        // assert
        expect(result, Left(AuthFailure(AuthFailureState.noMemberExists)));
      });
    });

    returnServerFailureWhenDeviceIsOffline(
        act: () => repository.login(tStudentNumber, tPassword));
  });

  group('getCurrentMember', () {
    checkOnline(
      arrange: () {
        when(mockAuthDataSource.getCurrentUser())
            .thenAnswer((realInvocation) async => tAuthUserModel);
        when(mockStoreDataSource.getMemberByStudentNumber(any))
            .thenAnswer((realInvocation) async => tFirestoreUserModel);
        when(mockMemberFactory.createFromModel(any)).thenReturn(tMember);
      },
      act: () async {
        await repository.getCurrentMember();
      },
    );

    group('device is online', () {
      setUp(() => when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true));

      test('should return member when data sources are successful', () async {
        // arrange
        when(mockAuthDataSource.getCurrentUser())
            .thenAnswer((realInvocation) async => tAuthUserModel);
        when(mockStoreDataSource.getMemberByStudentNumber(any))
            .thenAnswer((realInvocation) async => tFirestoreUserModel);
        when(mockMemberFactory.createFromModel(any)).thenReturn(tMember);
        // act
        final result = await repository.getCurrentMember();
        // assert
        verify(mockAuthDataSource.getCurrentUser());
        verify(mockStoreDataSource.getMemberByStudentNumber(tStudentNumber));
        verify(mockMemberFactory.createFromModel(tModels));
        expect(result, const Right(tMember));
      });

      test('should return auth failure when auth data source failed', () async {
        // arrange
        when(mockAuthDataSource.getCurrentUser())
            .thenThrow(FireAuthException('invalid-email'));
        // act
        final result = await repository.getCurrentMember();
        // assert
        verifyNever(mockStoreDataSource.getMemberByStudentNumber(any));
        verifyNever(mockMemberFactory.createFromModel(any));
        expect(result, Left(AuthFailure(AuthFailureState.invalidEmail)));
      });

      test(
          'should return the auth failure when member does not exist in data base',
          () async {
        // arrange
        when(mockAuthDataSource.getCurrentUser())
            .thenAnswer((realInvocation) async => tAuthUserModel);
        when(mockStoreDataSource.getMemberByStudentNumber(any))
            .thenThrow(FirestoreException('no-member'));
        // act
        final result = await repository.getCurrentMember();
        // assert
        expect(result, Left(AuthFailure(AuthFailureState.noMemberExists)));
      });
    });

    returnServerFailureWhenDeviceIsOffline(
        act: () => repository.getCurrentMember());
  });

  group('logout', () {
    checkOnline(
        arrange: () {},
        act: () {
          repository.logout(tStudentNumber);
        });

    group('device is online', () {
      setUp(() => when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true));

      test('should call logout member to log out', () async {
        // arrange
        when(mockAuthDataSource.logout(any))
            .thenAnswer((realInvocation) async {});
        // act
        final result = await repository.logout(tStudentNumber);
        // assert
        verify(mockAuthDataSource.logout(tStudentNumber));
        expect(result, const Right(unit));
      });

      test('should return auth failure when auth data source failed', () async {
        // arrange
        when(mockAuthDataSource.logout(tStudentNumber))
            .thenThrow(FireAuthException('invalid-email'));
        // act
        final result = await repository.logout(tStudentNumber);
        // assert
        expect(result, Left(AuthFailure(AuthFailureState.invalidEmail)));
      });
    });

    returnServerFailureWhenDeviceIsOffline(
        act: () => repository.logout(tStudentNumber));
  });

  group('getAuthState', () {
    test('should return stream', () {
      // arrange
      when(mockAuthDataSource.getAuthStateChanges())
          .thenAnswer((realInvocation) async* {
        yield tAuthUserModel;
      });
      when(mockStoreDataSource.getMemberByStudentNumber(tStudentNumber))
          .thenAnswer((realInvocation) async => tFirestoreUserModel);
      when(mockMemberFactory.createFromModel(any))
          .thenAnswer((realInvocation) => tMember);
      // act
      final result = repository.getAuthChange();
      // assert
      result.forEach((element) {
        expect(element, const Right(tMember));
      });
    });

    test('should return auth failure when auth data source failed', () async {
      // arrange
      when(mockAuthDataSource.getAuthStateChanges())
          .thenThrow(FireAuthException('invalid-email'));
      // act
      final result = repository.getAuthChange();
      // assert
      result.forEach((element) {
        expect(element, Left(AuthFailure(AuthFailureState.invalidEmail)));
      });
    });

    test(
        'should return the auth failure when member does not exist in data base',
        () async {
      // arrange
      when(mockAuthDataSource.getAuthStateChanges())
          .thenAnswer((realInvocation) async* {
        yield tAuthUserModel;
      });
      when(mockStoreDataSource.getMemberByStudentNumber(any))
          .thenThrow(FirestoreException('no-member'));
      // act
      final result = repository.getAuthChange();
      // assert
      result.forEach((element) {
        expect(element, Left(AuthFailure(AuthFailureState.noMemberExists)));
      });
    });
  });
}
