import 'package:cist_keion_app/core/error/exception/firebase_auth_exception.dart';
import 'package:cist_keion_app/core/error/exception/firestore_exception.dart';
import 'package:cist_keion_app/core/error/failure/auth/auth_failure.dart';
import 'package:cist_keion_app/core/error/failure/auth/auth_failure_state.dart';
import 'package:cist_keion_app/core/error/failure/failure.dart';
import 'package:cist_keion_app/core/error/failure/server/server_failure.dart';
import 'package:cist_keion_app/core/network/network_info.dart';
import 'package:cist_keion_app/feature/data/datasource/authentication_data_source.dart';
import 'package:cist_keion_app/feature/data/datasource/member_detail_remote_data_source.dart';
import 'package:cist_keion_app/feature/data/factory/auth/member_factory.dart';
import 'package:cist_keion_app/feature/data/model/auth/authentication_user_model.dart';
import 'package:cist_keion_app/feature/data/model/member_detail/institute_grade_model.dart';
import 'package:cist_keion_app/feature/data/model/member_detail/member_detail_model.dart';
import 'package:cist_keion_app/feature/data/repository/auth_repository_impl.dart';
import 'package:cist_keion_app/feature/domain/entity/auth/member.dart';
import 'package:cist_keion_app/feature/domain/value/institute_grade.dart';
import 'package:cist_keion_app/feature/domain/value/user_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([
  NetworkInfo,
  AuthenticationDataSource,
  MemberDetailRemoteDataSource,
  MemberFactory
])
void main() {
  late AuthRepositoryImpl repository;
  late MockNetworkInfo mockNetworkInfo;
  late MockAuthenticationDataSource mockAuthenticationDataSource;
  late MockMemberDetailRemoteDataSource mockMemberDetailRemoteDataSource;
  late MockMemberFactory mockMemberFactory;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockAuthenticationDataSource = MockAuthenticationDataSource();
    mockMemberDetailRemoteDataSource = MockMemberDetailRemoteDataSource();
    mockMemberFactory = MockMemberFactory();
    repository = AuthRepositoryImpl(
      networkInfo: mockNetworkInfo,
      authenticationDataSource: mockAuthenticationDataSource,
      memberDetailDataSource: mockMemberDetailRemoteDataSource,
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

  const tAuthUserModel = AuthenticationUserModel(
      email: tStudentNumber + emailDomainOfInstitute,
      studentNumber: tStudentNumber,
      isEmailVerify: false);

  const tMemberDetailModel = MemberDetailModel(
      id: 'testId',
      studentNumber: 'b2202260',
      name: 'testName',
      instituteGrade: InstituteGradeModel.first);

  const tModels = Models(
      authUserModel: tAuthUserModel, memberDetailModel: tMemberDetailModel);

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
        when(mockAuthenticationDataSource.createUser(any, any))
            .thenAnswer((realInvocation) async {});
        when(mockMemberDetailRemoteDataSource.getByStudentNumber(any))
            .thenAnswer((realInvocation) async => tMemberDetailModel);
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
        when(mockAuthenticationDataSource.createUser(any, any))
            .thenAnswer((realInvocation) async {});
        when(mockMemberDetailRemoteDataSource.getByStudentNumber(any))
            .thenAnswer((realInvocation) async => tMemberDetailModel);
        // act
        final result =
            await repository.registerMember(tStudentNumber, tPassword);
        // assert
        verify(
            mockAuthenticationDataSource.createUser(tStudentNumber, tPassword));
        expect(result, const Right(unit));
      });

      test('should return the auth failure when the auth datasource failed',
          () async {
        // arrange
        when(mockAuthenticationDataSource.createUser(any, any))
            .thenThrow(FireAuthException('invalid-email'));
        when(mockMemberDetailRemoteDataSource.getByStudentNumber(any))
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
        when(mockAuthenticationDataSource.createUser(any, any))
            .thenAnswer((realInvocation) async {});
        when(mockMemberDetailRemoteDataSource.getByStudentNumber(any))
            .thenThrow(FirestoreException('no-member'));
        // act
        final result =
            await repository.registerMember(tStudentNumber, tPassword);
        // assert
        verify(mockMemberDetailRemoteDataSource
            .getByStudentNumber(tStudentNumber));
        verifyNever(mockAuthenticationDataSource.createUser(any, any));
        expect(result, Left(AuthFailure(AuthFailureState.noMemberExists)));
      });
    });

    returnServerFailureWhenDeviceIsOffline(
        act: () => repository.registerMember(tStudentNumber, tPassword));
  });

  group('sendEmailVerify', () {
    checkOnline(
      arrange: () {
        when(mockAuthenticationDataSource.sendEmailVerify(any))
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
        when(mockAuthenticationDataSource.sendEmailVerify(any))
            .thenAnswer((realInvocation) async => {});
        // act
        final result = await repository.sendEmailVerify(tStudentNumber);
        // assert
        verify(mockAuthenticationDataSource.sendEmailVerify(tStudentNumber));
        expect(result, const Right(unit));
      });

      test('should return auth failure when sending email failed', () async {
        // arrange
        when(mockAuthenticationDataSource.sendEmailVerify(tStudentNumber))
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
        when(mockAuthenticationDataSource.login(any, any))
            .thenAnswer((realInvocation) async => tAuthUserModel);
        when(mockMemberDetailRemoteDataSource.getByStudentNumber(any))
            .thenAnswer((realInvocation) async => tMemberDetailModel);
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
        when(mockAuthenticationDataSource.login(any, any))
            .thenAnswer((realInvocation) async => tAuthUserModel);
        when(mockMemberDetailRemoteDataSource.getByStudentNumber(any))
            .thenAnswer((realInvocation) async => tMemberDetailModel);
        when(mockMemberFactory.createFromModel(any)).thenReturn(tMember);
        // act
        final result = await repository.login(tStudentNumber, tPassword);
        // assert
        verify(mockAuthenticationDataSource.login(tStudentNumber, tPassword));
        verify(mockMemberDetailRemoteDataSource
            .getByStudentNumber(tStudentNumber));
        expect(result, const Right(tMember));
      });

      test('should call factory to convert model', () async {
        // arrange
        when(mockAuthenticationDataSource.login(any, any))
            .thenAnswer((realInvocation) async => tAuthUserModel);
        when(mockMemberDetailRemoteDataSource.getByStudentNumber(any))
            .thenAnswer((realInvocation) async => tMemberDetailModel);
        when(mockMemberFactory.createFromModel(any)).thenReturn(tMember);
        // act
        final result = await repository.login(tStudentNumber, tPassword);
        // assert
        verify(mockMemberFactory.createFromModel(tModels));
        expect(result, const Right(tMember));
      });

      test('should return auth failure when auth data source failed', () async {
        // arrange
        when(mockAuthenticationDataSource.login(any, any))
            .thenThrow(FireAuthException('invalid-email'));
        // act
        final result = await repository.login(tStudentNumber, tPassword);
        // assert
        verifyNever(mockMemberDetailRemoteDataSource.getByStudentNumber(any));
        verifyNever(mockMemberFactory.createFromModel(any));
        expect(result, Left(AuthFailure(AuthFailureState.invalidEmail)));
      });

      test(
          'should return the auth failure when member does not exist in data base',
          () async {
        // arrange
        when(mockAuthenticationDataSource.login(any, any))
            .thenAnswer((realInvocation) async => tAuthUserModel);
        when(mockMemberDetailRemoteDataSource.getByStudentNumber(any))
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
        when(mockAuthenticationDataSource.getCurrentUser())
            .thenAnswer((realInvocation) async => tAuthUserModel);
        when(mockMemberDetailRemoteDataSource.getByStudentNumber(any))
            .thenAnswer((realInvocation) async => tMemberDetailModel);
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
        when(mockAuthenticationDataSource.getCurrentUser())
            .thenAnswer((realInvocation) async => tAuthUserModel);
        when(mockMemberDetailRemoteDataSource.getByStudentNumber(any))
            .thenAnswer((realInvocation) async => tMemberDetailModel);
        when(mockMemberFactory.createFromModel(any)).thenReturn(tMember);
        // act
        final result = await repository.getCurrentMember();
        // assert
        verify(mockAuthenticationDataSource.getCurrentUser());
        verify(mockMemberDetailRemoteDataSource
            .getByStudentNumber(tStudentNumber));
        verify(mockMemberFactory.createFromModel(tModels));
        expect(result, const Right(tMember));
      });

      test('should return auth failure when auth data source failed', () async {
        // arrange
        when(mockAuthenticationDataSource.getCurrentUser())
            .thenThrow(FireAuthException('invalid-email'));
        // act
        final result = await repository.getCurrentMember();
        // assert
        verifyNever(mockMemberDetailRemoteDataSource.getByStudentNumber(any));
        verifyNever(mockMemberFactory.createFromModel(any));
        expect(result, Left(AuthFailure(AuthFailureState.invalidEmail)));
      });

      test(
          'should return the auth failure when member does not exist in data base',
          () async {
        // arrange
        when(mockAuthenticationDataSource.getCurrentUser())
            .thenAnswer((realInvocation) async => tAuthUserModel);
        when(mockMemberDetailRemoteDataSource.getByStudentNumber(any))
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
        when(mockAuthenticationDataSource.logout(any))
            .thenAnswer((realInvocation) async {});
        // act
        final result = await repository.logout(tStudentNumber);
        // assert
        verify(mockAuthenticationDataSource.logout(tStudentNumber));
        expect(result, const Right(unit));
      });

      test('should return auth failure when auth data source failed', () async {
        // arrange
        when(mockAuthenticationDataSource.logout(tStudentNumber))
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
      when(mockAuthenticationDataSource.getAuthStateChanges())
          .thenAnswer((realInvocation) async* {
        yield tAuthUserModel;
      });
      when(mockMemberDetailRemoteDataSource.getByStudentNumber(tStudentNumber))
          .thenAnswer((realInvocation) async => tMemberDetailModel);
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
      when(mockAuthenticationDataSource.getAuthStateChanges())
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
      when(mockAuthenticationDataSource.getAuthStateChanges())
          .thenAnswer((realInvocation) async* {
        yield tAuthUserModel;
      });
      when(mockMemberDetailRemoteDataSource.getByStudentNumber(any))
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
