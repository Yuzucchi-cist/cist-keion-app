import 'package:flutter/material.dart';

Widget studentNumberFormField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: const InputDecoration(
      labelText: '学籍番号',
    ),
  );
}

Widget passwordFormField(
    TextEditingController controller, ValueNotifier<bool> isObscure) {
  return TextFormField(
    obscureText: isObscure.value,
    controller: controller,
    decoration: InputDecoration(
      labelText: 'パスワード',
      suffixIcon: IconButton(
        icon: Icon(
          isObscure.value ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: () {
          isObscure.value = !isObscure.value;
        },
      ),
    ),
  );
}

Widget confirmPasswordFormField(
    TextEditingController controller, ValueNotifier<bool> isObscure) {
  return TextFormField(
    obscureText: isObscure.value,
    controller: controller,
    decoration: InputDecoration(
      labelText: 'パスワード確認',
      suffixIcon: IconButton(
        icon: Icon(
          isObscure.value ? Icons.visibility_off : Icons.visibility,
        ),
        onPressed: () {
          isObscure.value = !isObscure.value;
        },
      ),
    ),
  );
}
