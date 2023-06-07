import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../widgets/user_data_form_field.dart';

@RoutePage()
class LoginPage extends HookConsumerWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO(yuzucchi): 画面の詳細設計
    final studentNumberController = useState(TextEditingController());
    final passwordController = useState(TextEditingController());
    final isPassObscure = useState(true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン'),
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
            studentNumberFormField(studentNumberController.value),
            passwordFormField(passwordController.value, isPassObscure),
            Row(
              children: [
                ElevatedButton(
                  child: const Text('ログイン'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.router
                          .push(const RootRoute(children: [HomeRoute()]));
                    }
                  },
                ),
                ElevatedButton(
                  child: const Text('登録'),
                  onPressed: () {
                    context.router.push(RegisterRoute());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
