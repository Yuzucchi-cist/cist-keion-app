import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../widgets/user_data_form_field.dart';

@RoutePage()
class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(yuzucchi): 画面の詳細設計
    final stNumController = useState(TextEditingController());
    final passController = useState(TextEditingController());
    final isPassObscure = useState(true);
    final confirmPassController = useState(TextEditingController());
    final isConfirmPassObscure = useState(true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('登録'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () =>
              context.navigateTo(const RootRoute(children: [HomeRoute()])),
        ),
      ),
      body: Form(
        child: Column(
          children: [
            studentNumberFormField(stNumController.value),
            passwordFormField(passController.value, isPassObscure),
            confirmPasswordFormField(
                confirmPassController.value, isConfirmPassObscure),
            TextButton(
              child: const Text('登録'),
              onPressed: () =>
                  context.router.push(const ConfirmEmailVerifyRoute()),
            ),
          ],
        ),
      ),
    );
  }
}
