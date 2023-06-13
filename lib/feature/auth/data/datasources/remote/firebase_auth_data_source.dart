import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/error/exception/firebase_auth_exception.dart';
import '../../models/firebase_auth/firebase_auth_user_model.dart';

abstract class FirebaseAuthDataSource {
  Future<void> createUser(String studentNumber, String password);
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  FirebaseAuthDataSourceImpl({required this.auth});

  final FirebaseAuth auth;

  @override
  Future<void> createUser(String studentNumber, String password) async {
    try {
      auth.createUserWithEmailAndPassword(
          email: studentNumber + emailDomainOfInstitute, password: password);
    } on FirebaseAuthException catch (e) {
      throw FireAuthException(e.code);
    }
  }
}
