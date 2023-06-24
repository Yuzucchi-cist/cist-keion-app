import 'package:cist_keion_app/core/usecases/usecase.dart';
import 'package:cist_keion_app/feature/auth/domain/entities/member.dart';
import 'package:cist_keion_app/feature/auth/domain/repositories/auth_repository.dart';
import 'package:cist_keion_app/feature/auth/domain/usecases/initialize_auth.dart';
import 'package:cist_keion_app/feature/auth/domain/values/institute_grade.dart';
import 'package:cist_keion_app/feature/auth/domain/values/user_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'initialize_auth_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late InitializeAuth usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = InitializeAuth(authRepository: mockAuthRepository);
  });

  const tMember = Member(
    memberId: 'tId',
    studentNumber: 'b2202260',
    name: 'tName',
    instituteGrade: InstituteGrade.first,
    userState: UserState.active,
    isVerified: false,
  );

  test('should return member when getting member is successful', () async {
    // arrange
    when(mockAuthRepository.getCurrentMember())
        .thenAnswer((realInvocation) async => const Right(tMember));
    // act
    final result = await usecase(NoParams());
    // arrange
    verify(mockAuthRepository.getCurrentMember());
    expect(result, const Right(tMember));
  });
}
