import 'package:cist_keion_app/core/usecases/usecase.dart';
import 'package:cist_keion_app/feature/domain/repository/auth_repository.dart';
import 'package:cist_keion_app/feature/domain/usecase/auth/logout.dart';
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

  test('should return result from repository', () async {
    // arrange
    when(mockAuthRepository.logout())
        .thenAnswer((realInvocation) async => const Right(unit));
    // act
    final result = await logout(NoParams());
    // assert
    verify(mockAuthRepository.logout());
    expect(result, const Right(unit));
  });
}
