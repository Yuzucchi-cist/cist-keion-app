import 'package:cist_keion_app/feature/data/model/auth/authentication/authentication_user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tStudentNumber = 'b2202260';
  const tEmail = '$tStudentNumber@photon.chitose.ac.jp';
  const tIsEmailVerify = false;

  const tModel = AuthenticationUserModel(
      email: tEmail,
      studentNumber: tStudentNumber,
      isEmailVerify: tIsEmailVerify);

  test('should create model from email address and isEmailVerify', () {
    // act
    final result = AuthenticationUserModel.fromEmail(
        email: tEmail, isEmailVerify: tIsEmailVerify);
    // assert
    expect(result, tModel);
  });

  test('should create model from student number and isEmailVerify', () {
    // act
    final result = AuthenticationUserModel.fromStudentNumber(
        studentNumber: tStudentNumber, isEmailVerify: tIsEmailVerify);
    // assert
    expect(result, tModel);
  });
}
