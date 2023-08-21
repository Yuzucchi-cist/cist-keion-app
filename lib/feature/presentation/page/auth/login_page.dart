import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../../provider/notifier/auth/auth_notifier.dart';
import '../../widget/auth/user_data_form_field.dart';
import '../../widget/show_error_dialog.dart';

@RoutePage()
class LoginPage extends HookConsumerWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final studentNumberController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPassObscure = useState(true);

    ref.listen(authProvider, (previous, next) async {
      await next.when(
          data: (authState) async {
            await authState.when(
                unAuthenticated: () {},
                unVerified: (_) async =>
                    context.router.push(const ConfirmEmailVerifyRoute()),
                authenticated: (member) async => context.router.push(RootRoute(
                    id: member.memberId, children: const [HomeRoute()])));
          },
          error: (error, stackTrace) async => showErrorDialog(
              context: context, titleText: '$error', contentText: '$error'),
          loading: () {
            // show loading
          });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('ログイン'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => context.navigateTo(const UnauthenticatedHomeRoute()),
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
                          .then((member) {})
                          .onError((error, _) {
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
