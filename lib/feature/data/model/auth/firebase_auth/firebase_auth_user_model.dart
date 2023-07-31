import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/firebase_auth_user_model.freezed.dart';

const emailDomainOfInstitute = '@photon.chitose.ac.jp';

@freezed
class FirebaseAuthUserModel with _$FirebaseAuthUserModel {
  const factory FirebaseAuthUserModel({
    required String email,
    required String studentNumber,
    required bool isEmailVerify,
  }) = _FirebaseAuthUserModel;

  factory FirebaseAuthUserModel.fromEmail(
      {required String email, required bool isEmailVerify}) {
    final studentNumber = email.split(RegExp(r'@')).first;
    return FirebaseAuthUserModel(
      email: email,
      studentNumber: studentNumber,
      isEmailVerify: isEmailVerify,
    );
  }

  factory FirebaseAuthUserModel.fromStudentNumber(
      {required String studentNumber, required bool isEmailVerify}) {
    final email = '$studentNumber$emailDomainOfInstitute';
    return FirebaseAuthUserModel(
      email: email,
      studentNumber: studentNumber,
      isEmailVerify: isEmailVerify,
    );
  }
}
