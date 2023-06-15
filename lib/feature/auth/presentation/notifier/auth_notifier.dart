import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/error/failure/auth/auth_failure.dart';
import '../../../../core/error/failure/server/server_failure.dart';
import '../../../../core/provider_di.dart';
import '../../domain/usecases/register_member.dart';
import '../states/auth_state.dart';

final authProvider = StateNotifierProvider(
    (ref) => AuthNotifier(registerMember: ref.watch(registerMemberProvider)));

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({required this.registerMember})
      : super(const AuthState.unAuthenticated());

  final RegisterMember registerMember;

  Future<void> register(String studentNumber, String password) async {
    final params = Params(studentNumber: studentNumber, password: password);
    final result = await registerMember(params);
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
}
