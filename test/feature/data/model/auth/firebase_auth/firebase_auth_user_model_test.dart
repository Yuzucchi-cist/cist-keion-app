import 'package:cist_keion_app/feature/data/model/auth/firebase_auth/firebase_auth_user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tStudentNumber = 'b2202260';
  const tEmail = '$tStudentNumber@photon.chitose.ac.jp';
  const tIsEmailVerify = false;

  const tModel = FirebaseAuthUserModel(
      email: tEmail,
      studentNumber: tStudentNumber,
      isEmailVerify: tIsEmailVerify);

  test('should create model from email address and isEmailVerify', () {
    // act
    final result = FirebaseAuthUserModel.fromEmail(
        email: tEmail, isEmailVerify: tIsEmailVerify);
    // assert
    expect(result, tModel);
  });

  test('should create model from student number and isEmailVerify', () {
    // act
    final result = FirebaseAuthUserModel.fromStudentNumber(
        studentNumber: tStudentNumber, isEmailVerify: tIsEmailVerify);
    // assert
    expect(result, tModel);
  });
}
