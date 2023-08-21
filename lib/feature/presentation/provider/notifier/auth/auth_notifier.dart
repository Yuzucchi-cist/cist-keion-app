import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/error/failure/auth/auth_failure.dart';
import '../../../../../core/error/failure/auth/auth_failure_state.dart';
import '../../../../../core/error/failure/server/server_failure.dart';
import '../../../../../core/provider_di.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../domain/usecase/auth/login.dart';
import '../../../../domain/usecase/auth/register_member.dart';
import '../../state/auth/auth_state.dart';

final authProvider =
    AsyncNotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<AuthState> {
  AuthNotifier() : super();

  @override
  FutureOr<AuthState> build() {
    return _initialize();
  }

  Future<AuthState> _initialize() async {
    final result = await ref.read(initializeProvider)(NoParams());
    return result.fold(
      (failure) {
        if (failure is AuthFailure) {
          if (failure.state == AuthFailureState.userNotLogin) {
            return const AuthState.unAuthenticated();
          }
        } else if (failure is ServerFailure) {
          throw Exception('ネットワークに接続してください。');
        } else {
          throw Exception('unknown error occurred');
        }
        return const AuthState.unAuthenticated();
      },
      (member) {
        if (member.isVerified) {
          return AuthState.authenticated(member);
        } else {
          return AuthState.unVerified(member);
        }
      },
    );
  }

  Future<void> register(String studentNumber, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final params =
          RegisterParams(studentNumber: studentNumber, password: password);
      final result = await ref.read(registerMemberProvider)(params);

      return result.fold(
        (failure) {
          if (failure is AuthFailure) {
            throw Exception(failure.state.toString());
          } else if (failure is ServerFailure) {
            throw Exception('ネットワークに接続してください。');
          } else {
            throw Exception('unknown error occurred');
          }
        },
        (unit) => const AuthState.unAuthenticated(),
      );
    });
  }

  Future<void> login(String studentNumber, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final params =
          LoginParams(studentNumber: studentNumber, password: password);

      final result = await ref.read(loginProvider)(params);
      return result.fold(
        (failure) {
          if (failure is AuthFailure) {
            throw Exception(failure.state.toString());
          } else if (failure is ServerFailure) {
            throw Exception('ネットワークに接続してください。');
          } else {
            throw Exception('unknown error occurred');
          }
        },
        (member) {
          if (member.isVerified) {
            return AuthState.authenticated(member);
          } else {
            return AuthState.unVerified(member);
          }
        },
      );
    });
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    (await ref.read(logoutProvider)(NoParams())).fold((failure) {
      if (failure is AuthFailure) {
        throw Exception(failure.state.toString());
      } else if (failure is ServerFailure) {
        throw Exception('ネットワークに接続してください。');
      } else {
        throw Exception('unknown error occurred');
      }
    }, (unit) => {});
    state = const AsyncData(AuthState.unAuthenticated());
  }
}
