import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(yuzucchi): 画面の詳細設計

    final stNumController = useState(TextEditingController());
    final passController = useState(TextEditingController());
    final isPassObscure = useState(true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('登録'),
        centerTitle: true,
      ),
      body: Form(
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
                    isPassObscure.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    isPassObscure.value = !isPassObscure.value;
                  },
                ),
              ),
            ),
            TextButton(
              child: const Text('登録'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
