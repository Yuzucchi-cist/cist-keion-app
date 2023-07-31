import 'package:cist_keion_app/feature/domain/entity/auth/member.dart';
import 'package:cist_keion_app/feature/domain/repository/auth_repository.dart';
import 'package:cist_keion_app/feature/domain/usecase/auth/login.dart';
import 'package:cist_keion_app/feature/domain/value/institute_grade.dart';
import 'package:cist_keion_app/feature/domain/value/user_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late Login usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = Login(authRepository: mockAuthRepository);
  });

  const tStudentNumber = 'b2202260';
  const tPassword = 'Cist1234';
  final tParams =
      LoginParams(studentNumber: tStudentNumber, password: tPassword);

  const tMember = Member(
    memberId: 'tId',
    studentNumber: tStudentNumber,
    name: 'tName',
    instituteGrade: InstituteGrade.first,
    userState: UserState.active,
    isVerified: false,
  );

  test('should return member from repository', () async {
    // arrange
    when(mockAuthRepository.login(any, any))
        .thenAnswer((realInvocation) async => const Right(tMember));
    // act
    final result = await usecase(tParams);
    // assert
    verify(mockAuthRepository.login(tStudentNumber, tPassword));
    expect(result, const Right(tMember));
  });
}
