import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../notifier/auth_notifier.dart';
import '../widgets/showErrorDialog.dart';
import '../widgets/user_data_form_field.dart';

@RoutePage()
class LoginPage extends HookConsumerWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final studentNumberController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPassObscure = useState(true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => context.navigateTo(const RootRoute()),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            studentNumberFormField(studentNumberController),
            passwordFormField(passwordController, isPassObscure),
            Row(
              children: [
                ElevatedButton(
                  child: const Text('ログイン'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final studentNumber = studentNumberController.text;
                      final password = passwordController.text;
                      ref
                          .read(authProvider.notifier)
                          .login(studentNumber, password)
                          .then((member) {
                        if (member.isVerified) {
                          context.router
                              .push(const RootRoute(children: [HomeRoute()]));
                        } else {
                          context.router.push(const ConfirmEmailVerifyRoute());
                        }
                      }).onError((error, _) {
                        showErrorDialog(
                          context: context,
                          titleText: 'ERROR',
                          contentText: error.toString(),
                        );
                      });
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
