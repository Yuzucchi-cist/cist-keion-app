import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/error/exception/firebase_auth_exception.dart';
import '../../models/firebase_auth/firebase_auth_user_model.dart';

abstract class FirebaseAuthDataSource {
  Future<void> createUser(String studentNumber, String password);
  Future<FirebaseAuthUserModel> login(String studentNumber, String password);
  Future<void> sendEmailVerify(String studentNumber);
  Future<FirebaseAuthUserModel> getCurrentUser();
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  FirebaseAuthDataSourceImpl({required this.auth});

  final FirebaseAuth auth;

  @override
  Future<void> createUser(String studentNumber, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: studentNumber + emailDomainOfInstitute, password: password);
    } on FirebaseAuthException catch (e) {
      throw FireAuthException(e.code);
    }
  }

  @override
  Future<FirebaseAuthUserModel> login(
      String studentNumber, String password) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
          email: studentNumber + emailDomainOfInstitute, password: password);
      final user = userCredential.user!;
      return FirebaseAuthUserModel.fromEmail(
          email: user.email!, isEmailVerify: user.emailVerified);
    } on FirebaseAuthException catch (e) {
      throw FireAuthException(e.code);
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
      throw FireAuthException(e.code);
    }
  }

  @override
  Future<FirebaseAuthUserModel> getCurrentUser() async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser != null) {
        return FirebaseAuthUserModel.fromEmail(
            email: currentUser.email!,
            isEmailVerify: currentUser.emailVerified);
      } else {
        throw FireAuthException(errorCodeUserNotLoggedIn);
      }
    } on FirebaseAuthException catch (e) {
      throw FireAuthException(e.code);
    }
  }
}
