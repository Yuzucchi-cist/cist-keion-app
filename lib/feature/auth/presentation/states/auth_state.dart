import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/member.dart';

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

  String get id => when(
      unAuthenticated: () => '',
      unVerified: (_) => '',
      authenticated: (member) => member.memberId);
}
