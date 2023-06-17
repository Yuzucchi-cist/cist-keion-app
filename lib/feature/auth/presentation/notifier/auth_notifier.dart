import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/error/failure/auth/auth_failure.dart';
import '../../../../core/error/failure/server/server_failure.dart';
import '../../../../core/provider_di.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register_member.dart';
import '../states/auth_state.dart';

final authProvider = StateNotifierProvider((ref) => AuthNotifier(
    registerMemberUsecase: ref.watch(registerMemberProvider),
    loginUsecase: ref.watch(loginProvider)));

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(
      {required this.registerMemberUsecase, required this.loginUsecase})
      : super(const AuthState.unAuthenticated());

  final RegisterMember registerMemberUsecase;
  final Login loginUsecase;

  Future<void> register(String studentNumber, String password) async {
    final params =
        RegisterParams(studentNumber: studentNumber, password: password);
    final result = await registerMemberUsecase(params);
    result.fold(
      (failure) {
        if (failure is AuthFailure) {
          throw Exception(failure.state.toString());
        } else if (failure is ServerFailure) {
          throw Exception('ネットワークに接続してください。');
        }
      },
      (r) => null,
    );
  }

  Future<void> login(String studentNumber, String password) async {
    final params =
        LoginParams(studentNumber: studentNumber, password: password);
    final result = await loginUsecase(params);
    result.fold(
      (failure) {
        if (failure is AuthFailure) {
          throw Exception(failure.state.toString());
        } else if (failure is ServerFailure) {
          throw Exception('ネットワークに接続してください。');
        }
      },
      (member) {
        if (member.isVerified) {
          state = AuthState.authenticated(member);
        } else {
          state = AuthState.unVerified(member);
        }
      },
    );
  }
}
