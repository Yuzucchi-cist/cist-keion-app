import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/input_user_imformation.dart';

@RoutePage()
class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(yuzucchi): 画面の詳細設計

    return Scaffold(
      appBar: AppBar(
        title: const Text('登録'),
        centerTitle: true,
      ),
      body: const InputUserInformation(isLoginForm: false),
    );
  }
}
