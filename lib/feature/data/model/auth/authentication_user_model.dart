import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/authentication_user_model.freezed.dart';

const emailDomainOfInstitute = '@photon.chitose.ac.jp';

@freezed
class AuthenticationUserModel with _$AuthenticationUserModel {
  const factory AuthenticationUserModel({
    required String email,
    required String studentNumber,
    required bool isEmailVerify,
  }) = _AuthenticationUserModel;

  factory AuthenticationUserModel.fromEmail(
      {required String email, required bool isEmailVerify}) {
    final studentNumber = email.split(RegExp(r'@')).first;
    return AuthenticationUserModel(
      email: email,
      studentNumber: studentNumber,
      isEmailVerify: isEmailVerify,
    );
  }

  factory AuthenticationUserModel.fromStudentNumber(
      {required String studentNumber, required bool isEmailVerify}) {
    final email = '$studentNumber$emailDomainOfInstitute';
    return AuthenticationUserModel(
      email: email,
      studentNumber: studentNumber,
      isEmailVerify: isEmailVerify,
    );
  }
}
