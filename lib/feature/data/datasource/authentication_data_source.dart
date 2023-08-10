import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error/exception/firebase_auth_exception.dart';
import '../model/auth/authentication/authentication_user_model.dart';

abstract class AuthenticationDataSource {
  Future<void> createUser(String studentNumber, String password);
  Future<AuthenticationUserModel> login(String studentNumber, String password);
  Future<void> logout(String studentNumber);
  Future<void> sendEmailVerify(String studentNumber);
  Future<AuthenticationUserModel> getCurrentUser();
  Stream<AuthenticationUserModel?> getAuthStateChanges();
}

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  AuthenticationDataSourceImpl({required this.auth});

  final FirebaseAuth auth;

  @override
  Future<void> createUser(String studentNumber, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: studentNumber + emailDomainOfInstitute, password: password);
    } on FirebaseAuthException catch (e) {
      throw FireAuthException.fromMessage(e.message);
    }
  }

  @override
  Future<AuthenticationUserModel> login(
      String studentNumber, String password) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
          email: studentNumber + emailDomainOfInstitute, password: password);
      final user = userCredential.user!;
      return AuthenticationUserModel.fromEmail(
          email: user.email!, isEmailVerify: user.emailVerified);
    } on FirebaseAuthException catch (e) {
      throw FireAuthException.fromMessage(e.message);
    }
  }

  @override
  Future<void> sendEmailVerify(String studentNumber) async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        currentUser.sendEmailVerification();
      } else {
        throw FireAuthException(errorCodeUserNotLoggedIn);
      }
    } on FirebaseAuthException catch (e) {
      throw FireAuthException.fromMessage(e.message);
    }
  }

  @override
  Future<AuthenticationUserModel> getCurrentUser() async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        return AuthenticationUserModel.fromEmail(
            email: currentUser.email!,
            isEmailVerify: currentUser.emailVerified);
      } else {
        throw FireAuthException(errorCodeUserNotLoggedIn);
      }
    } on FirebaseAuthException catch (e) {
      throw FireAuthException.fromMessage(e.message);
    }
  }

  @override
  Stream<AuthenticationUserModel?> getAuthStateChanges() {
    try {
      return auth.authStateChanges().map((user) {
        if (user != null) {
          return AuthenticationUserModel.fromEmail(
              email: user.email!, isEmailVerify: user.emailVerified);
        } else {
          return null;
        }
      });
    } on FirebaseAuthException catch (e) {
      throw FireAuthException.fromMessage(e.message);
    }
  }

  @override
  Future<void> logout(String studentNumber) async {
    if (auth.currentUser != null) {
      auth.signOut();
    } else {
      throw FireAuthException(errorCodeUserNotLoggedIn);
    }
  }
}
