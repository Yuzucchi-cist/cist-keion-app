import 'package:cist_keion_app/core/error/exception/firebase_auth_exception.dart';
import 'package:cist_keion_app/feature/auth/data/datasources/remote/firebase_auth_data_source.dart';
import 'package:cist_keion_app/feature/auth/data/models/firebase_auth/firebase_auth_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'firebase_auth_data_source_test.mocks.dart';

@GenerateMocks([FirebaseAuth, UserCredential, User])
void main() {
  late FirebaseAuthDataSourceImpl dataSource;
  late MockFirebaseAuth mockFirebaseAuth;
  final mockUserCredential = MockUserCredential();
  final mockUser = MockUser();

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    dataSource = FirebaseAuthDataSourceImpl(auth: mockFirebaseAuth);
  });

  when(mockUserCredential.user).thenAnswer((_) => mockUser);
  when(mockUser.emailVerified).thenAnswer((_) => false);

  const tStudentNumber = 'b2202260';
  const tEmail = tStudentNumber + emailDomainOfInstitute;
  const tPassword = 'Cist1234';
  const testErrorCode = 'testErrorCode';

  group('signUp', () {
    test('should call createUserWithEmailAndPassword to create user', () async {
      // arrange
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) async => mockUserCredential);
      // act
      await dataSource.createUser(tStudentNumber, tPassword);
      // assert
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: tEmail, password: tPassword));
    });

    test('should throw AuthException when creation is failed', () async {
      // arrange
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: tEmail, password: tPassword))
          .thenThrow(FirebaseAuthException(code: testErrorCode));
      try {
        // act
        await dataSource.createUser(tStudentNumber, tPassword);
        // assert
      } on FireAuthException catch (e) {
        expect(e.code, testErrorCode);
      } catch (e) {
        fail('Not-expect object was thrown');
      }
    });
  });

  group('sendEmailVerify', () {
    test('should call sendEmailVerify to send email verify', () {
      // arrange
      when(mockFirebaseAuth.currentUser)
          .thenAnswer((realInvocation) => mockUser);
      // act
      dataSource.sendEmailVerify(tStudentNumber);
      // assert
      verify(mockUser.sendEmailVerification());
    });

    test('should throw Auth Exception when user has not login', () async {
      // arrange
      when(mockFirebaseAuth.currentUser).thenAnswer((realInvocation) => null);
      try {
        // act
        await dataSource.sendEmailVerify(tStudentNumber);
        fail('');
      } on FireAuthException catch (e) {
        // assert
        verifyNever(mockUser.sendEmailVerification());
        expect(e.code, errorCodeUserNotLoggedIn);
      } catch (e) {
        fail('Not-expect object was thrown');
      }
    });

    test('should throw AuthException when sending email verify failed',
        () async {
      // arrange
      when(mockFirebaseAuth.currentUser)
          .thenAnswer((realInvocation) => mockUser);
      when(mockUser.sendEmailVerification())
          .thenThrow(FirebaseAuthException(code: testErrorCode));
      try {
        // act
        await dataSource.sendEmailVerify(tStudentNumber);
        fail('');
      } on FireAuthException catch (e) {
        expect(e.code, testErrorCode);
      } catch (e) {
        fail('Not-expect object was thrown');
      }
    });
  });
}
