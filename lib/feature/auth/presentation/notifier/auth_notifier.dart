import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    await registerMember(params);
  }
}
