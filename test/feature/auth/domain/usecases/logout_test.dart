import 'package:cist_keion_app/feature/auth/domain/repositories/auth_repository.dart';
import 'package:cist_keion_app/feature/auth/domain/usecases/logout.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late Logout logout;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    logout = Logout(authRepository: mockAuthRepository);
  });

  const tStudentNumber = 'b2202260';

  test('should return result from repository', () async {
    // arrange
    when(mockAuthRepository.logout(any))
        .thenAnswer((realInvocation) async => const Right(unit));
    // act
    final result = await logout(tStudentNumber);
    // assert
    verify(mockAuthRepository.logout(tStudentNumber));
    expect(result, const Right(unit));
  });
}
