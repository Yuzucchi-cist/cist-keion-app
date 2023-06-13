import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/member.dart';

part 'generated/auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unAuthenticated() = _unAuthenticated;
  const factory AuthState.unVerified(Member member) = _unVerified;
  const factory AuthState.authenticated(Member member) = _authenticated;
}
