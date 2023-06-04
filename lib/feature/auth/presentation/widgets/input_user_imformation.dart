import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';

class InputUserInformation extends HookConsumerWidget {
  const InputUserInformation({super.key, required this.isLoginForm});

  final bool isLoginForm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stNumController = useState(TextEditingController());
    final passController = useState(TextEditingController());
    final isPassObscure = useState(true);

    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: stNumController.value,
            decoration: const InputDecoration(
              labelText: '学籍番号',
            ),
          ),
          TextFormField(
            obscureText: isPassObscure.value,
            controller: passController.value,
            decoration: InputDecoration(
              labelText: 'パスワード',
              suffixIcon: IconButton(
                icon: Icon(
                  isPassObscure.value ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  isPassObscure.value = !isPassObscure.value;
                },
              ),
            ),
          ),
          if (isLoginForm)
            Row(
              children: [
                TextButton(
                  child: const Text('ログイン'),
                  onPressed: () => context.router.push(const HomeRoute()),
                ),
                TextButton(
                  child: const Text('登録'),
                  onPressed: () => context.router.push(const RegisterRoute()),
                ),
              ],
            )
          else
            TextButton(
              child: const Text('登録'),
              onPressed: () =>
                  context.router.push(const ConfirmEmailVerifyRoute()),
            ),
        ],
      ),
    );
  }
}
