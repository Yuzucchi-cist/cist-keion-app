import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/error/failure/auth/auth_failure.dart';
import '../../../../core/error/failure/auth/auth_failure_state.dart';
import '../../../../core/error/failure/server/server_failure.dart';
import '../../../../core/provider_di.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/member.dart';
import '../../domain/usecases/get_member_stream.dart';
import '../../domain/usecases/initialize_auth.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register_member.dart';
import '../states/auth_state.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(
    registerMemberUsecase: ref.watch(registerMemberProvider),
    loginUsecase: ref.watch(loginProvider),
    initializeAuthUsecase: ref.watch(initializeProvider),
    getMemberStream: ref.watch(getAuthStateProvider),
  ),
);

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({
    required this.registerMemberUsecase,
    required this.loginUsecase,
    required this.initializeAuthUsecase,
    required this.getMemberStream,
  }) : super(const AuthState.unAuthenticated());

  final RegisterMember registerMemberUsecase;
  final Login loginUsecase;
  final InitializeAuth initializeAuthUsecase;
  final GetMemberStream getMemberStream;

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

  Future<Member> login(String studentNumber, String password) async {
    final params =
        LoginParams(studentNumber: studentNumber, password: password);
    final result = await loginUsecase(params);
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
          state = AuthState.authenticated(member);
        } else {
          state = AuthState.unVerified(member);
        }
        return member;
      },
    );
  }

  Future<Member?> initialize() async {
    final result = await initializeAuthUsecase(NoParams());
    return result.fold(
      (failure) {
        if (failure is AuthFailure) {
          if (failure.state == AuthFailureState.userNotLogin) {
            return null;
          }
        } else if (failure is ServerFailure) {
          throw Exception('ネットワークに接続してください。');
        } else {
          throw Exception('unknown error occurred');
        }
        return null;
      },
      (member) {
        if (member.isVerified) {
          state = AuthState.authenticated(member);
        } else {
          state = AuthState.unVerified(member);
        }
        return member;
      },
    );
  }

  Stream<Member?> authStateChanges() {
    print('T');
    return getMemberStream(NoParams()).map((result) {
      return result.fold((failure) {
        if (failure is AuthFailure) {
          if (failure.state == AuthFailureState.userNotLogin) {
            return null;
          }
          throw Exception(failure.state.toString());
        } else if (failure is ServerFailure) {
          throw Exception('ネットワークに接続してください。');
        } else {
          throw Exception('unknown error occurred');
        }
      }, (member) {
        if (member.isVerified) {
          state = AuthState.authenticated(member);
        } else {
          state = AuthState.unVerified(member);
        }
        return member;
      });
    });
  }
}
