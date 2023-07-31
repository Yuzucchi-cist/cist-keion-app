import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/notifier/auth/auth_notifier.dart';

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
              unAuthenticated: () => const Text('ログインしてください。'),
              unVerified: (_) => const Text('ログインしてください。'),
              authenticated: (member) => Center(
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
                      child: const Text('ログアウト'),
                      onPressed: () {
                        ref
                            .read(authProvider.notifier)
                            .logout(member.studentNumber);
                      },
                    )
                  ],
                ),
              ),
            ));
  }
}
