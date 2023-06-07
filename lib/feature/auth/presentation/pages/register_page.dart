import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../widgets/user_data_form_field.dart';

@RoutePage()
class RegisterPage extends HookConsumerWidget {
  RegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _studentNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(yuzucchi): 画面の詳細設計
    final isPasswordObscure = useState(true);
    final isConfirmPasswordObscure = useState(true);

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
        key: _formKey,
        child: Column(
          children: [
            studentNumberFormField(_studentNumberController),
            passwordFormField(_passwordController, isPasswordObscure),
            confirmPasswordFormField(_passwordController,
                _confirmPasswordController, isConfirmPasswordObscure),
            ElevatedButton(
              child: const Text('登録'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.router.push(const ConfirmEmailVerifyRoute());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
