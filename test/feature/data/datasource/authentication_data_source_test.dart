import 'package:cist_keion_app/core/error/exception/firebase_auth_exception.dart';
import 'package:cist_keion_app/feature/data/datasource/authentication_data_source.dart';
import 'package:cist_keion_app/feature/data/model/auth/authentication/authentication_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authentication_data_source_test.mocks.dart';

@GenerateMocks([FirebaseAuth, UserCredential, User])
void main() {
  late AuthenticationDataSourceImpl dataSource;
  late MockFirebaseAuth mockFirebaseAuth;
  final mockUserCredential = MockUserCredential();
  final mockUser = MockUser();

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    dataSource = AuthenticationDataSourceImpl(auth: mockFirebaseAuth);
  });

  const tStudentNumber = 'b2202260';
  const tEmail = tStudentNumber + emailDomainOfInstitute;
  const tPassword = 'Cist1234';
  const tUserModel = AuthenticationUserModel(
      email: tEmail, studentNumber: tStudentNumber, isEmailVerify: false);

  const testErrorCode = 'test-error-code';
  const testErrorMessage =
      'An unknown error occurred: FirebaseError: Firebase: Test error occurred. (auth/$testErrorCode).';

  when(mockUserCredential.user).thenAnswer((_) => mockUser);
  when(mockUser.email).thenAnswer((realInvocation) => tEmail);
  when(mockUser.emailVerified).thenAnswer((_) => false);

  group('createUser', () {
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
          .thenThrow(FirebaseAuthException(
              code: testErrorCode, message: testErrorMessage));
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

  group('login', () {
    test('should call signInWithEmailAndPassword to login', () async {
      // arrange
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((realInvocation) async => mockUserCredential);
      // act
      final result = await dataSource.login(tStudentNumber, tPassword);
      // assert
      verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: tEmail, password: tPassword));
      expect(result, tUserModel);
    });

    test('should throw AuthException when login is failed', () async {
      // arrange
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenThrow(FirebaseAuthException(
              code: testErrorCode, message: testErrorMessage));
      try {
        // act
        await dataSource.login(tStudentNumber, tPassword);
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
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      // act
      dataSource.sendEmailVerify(tStudentNumber);
      // assert
      verify(mockUser.sendEmailVerification());
    });

    test('should throw Auth Exception when user has not login', () async {
      // arrange
      when(mockFirebaseAuth.currentUser).thenReturn(null);
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
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(mockUser.sendEmailVerification()).thenThrow(FirebaseAuthException(
          code: testErrorCode, message: testErrorMessage));
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

  group('getCurrentUser', () {
    test('should return member when firebase auth is successful', () async {
      // arrange
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      // act
      final result = await dataSource.getCurrentUser();
      // assert
      verify(mockFirebaseAuth.currentUser);
      expect(result, tUserModel);
    });

    test('should throw Auth Exception when user has not login', () async {
      // arrange
      when(mockFirebaseAuth.currentUser).thenReturn(null);
      try {
        // act
        await dataSource.getCurrentUser();
        fail('');
      } on FireAuthException catch (e) {
        // assert
        expect(e.code, errorCodeUserNotLoggedIn);
      } catch (e) {
        fail('Not-expect object was thrown');
      }
    });
  });

  group('logout', () {
    test('should call logout', () async {
      // arrange
      when(mockFirebaseAuth.signOut()).thenAnswer((realInvocation) async {});
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      // act
      await dataSource.logout(tStudentNumber);
      // assert
      verify(mockFirebaseAuth.signOut());
    });

    test('should throw Auth Exception when user has not login', () async {
      // arrange
      when(mockFirebaseAuth.currentUser).thenReturn(null);
      try {
        // act
        await dataSource.logout(tStudentNumber);
        // assert
        verify(mockFirebaseAuth.currentUser);
        fail('');
      } on FireAuthException catch (e) {
        expect(e.code, errorCodeUserNotLoggedIn);
      } catch (e) {
        fail('Not-expect object was thrown');
      }
    });
  });

  group('getAuthStateChanges', () {
    group('should return stream from firebase', () {
      test('should return member when firebase auth is successful', () async {
        // arrange
        when(mockFirebaseAuth.authStateChanges())
            .thenAnswer((realInvocation) async* {
          yield mockUser;
        });
        // act
        final result = dataSource.getAuthStateChanges();
        // assert
        result.forEach((element) {
          expect(element, tUserModel);
        });
      });

      test('should return null when user has not login', () async {
        // arrange
        when(mockFirebaseAuth.authStateChanges())
            .thenAnswer((realInvocation) async* {
          yield null;
        });
        // act
        final result = dataSource.getAuthStateChanges();
        // assert
        result.forEach((element) {
          expect(element, null);
        });
      });
    });
  });
}
