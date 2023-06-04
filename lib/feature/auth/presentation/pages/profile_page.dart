import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(yuzucchi): 認証を追加
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール'),
      ),
      body: const Column(
        children: [
          Text('名前'),
          Text('学年'),
        ],
      ),
    );
  }
}
