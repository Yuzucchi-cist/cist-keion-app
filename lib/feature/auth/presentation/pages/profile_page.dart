import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifier/auth_notifier.dart';

@RoutePage()
class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(yuzucchi): 認証を追加
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
                    Text(member.name),
                    Text(member.studentNumber),
                    Text(member.instituteGrade.jpString),
                    Text(member.userState.name),
                  ],
                ),
              ),
            ));
  }
}
