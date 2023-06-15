import 'package:cist_keion_app/feature/auth/domain/repositories/auth_repository.dart';
import 'package:cist_keion_app/feature/auth/domain/usecases/register_member.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_member_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late RegisterMember usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = RegisterMember(authRepository: mockAuthRepository);
  });

  const tStudentNumber = 'b2202260';
  const tPassword = 'Cist1234';
  final tParams = Params(studentNumber: tStudentNumber, password: tPassword);

  test('should return unit(void) from repository', () async {
    // arrange
    when(mockAuthRepository.registerMember(any, any))
        .thenAnswer((_) async => const Right(unit));
    when(mockAuthRepository.sendEmailVerify(any))
        .thenAnswer((realInvocation) async => const Right(unit));
    // act
    final result = await usecase(tParams);
    // assert
    verify(mockAuthRepository.registerMember(tStudentNumber, tPassword));
    expect(result, const Right(unit));
  });

  test('should call the sending email verify', () async {
    // arrange
    when(mockAuthRepository.sendEmailVerify(any))
        .thenAnswer((realInvocation) async => const Right(unit));
    when(mockAuthRepository.registerMember(any, any))
        .thenAnswer((_) async => const Right(unit));
    // act
    await usecase(tParams);
    // assert
    verify(mockAuthRepository.sendEmailVerify(tStudentNumber));
  });
}
