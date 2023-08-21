import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entity/auth/member.dart';

part 'generated/auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();
  const factory AuthState.unAuthenticated() = _unAuthenticated;
  const factory AuthState.unVerified(Member member) = _unVerified;
  const factory AuthState.authenticated(Member member) = _authenticated;

  bool get isAuthenticated => when(
        unAuthenticated: () => false,
        unVerified: (_) => false,
        authenticated: (_) => true,
      );

  bool get isAdmin => when(
        unAuthenticated: () => false,
        unVerified: (_) => false,
        authenticated: (member) => member.isAdmin,
      );

  Member? get member => when(
      unAuthenticated: () => null,
      unVerified: (_) => null,
      authenticated: (member) => member);
}
