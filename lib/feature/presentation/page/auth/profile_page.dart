import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../../provider/notifier/auth/auth_notifier.dart';
import '../../provider/state/auth/auth_state.dart';

@RoutePage()
class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ref.watch(authProvider).when(
          data: (authState) => proile(
                authState,
                () {
                  ref.read(authProvider.notifier).logout().then((value) {
                    // ログアウト完了のダイアログ表示
                    context.router.navigate(const UnauthenticatedHomeRoute());
                  });
                },
              ),
          error: (error, _) {
            // show error
            return const Text('ログインしてください。');
          },
          loading: () {
            // show loading
            return const Text('ログインしてください。');
          }),
    );
  }

  Widget proile(AuthState state, void Function() handleLogout) {
    final member = state.member;
    return member == null
        ? const Text('ログインしてください')
        : Center(
            child: Column(
              children: [
                Column(
                  children: [
                    if (member.isAdmin) const Text('管理者'),
                    Text(member.name),
                    Text(member.studentNumber),
                    Text(member.instituteGrade.jpString),
                    Text(member.userState.name),
                  ],
                ),
                ElevatedButton(
                  onPressed: handleLogout,
                  child: const Text('ログアウト'),
                )
              ],
            ),
          );
  }
}
