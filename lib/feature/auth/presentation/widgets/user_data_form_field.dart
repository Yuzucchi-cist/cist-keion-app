import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget studentNumberFormField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-z\d]'))],
    validator: (value) {
      final regExp = RegExp(r'[a-z]\d{6}0');
      if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
        return '学籍番号に誤りがあります。';
      }
      return null;
    },
    decoration: const InputDecoration(
      labelText: '学籍番号',
    ),
  );
}

Widget passwordFormField(
    TextEditingController controller, ValueNotifier<bool> isObscure) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextFormField(
        obscureText: isObscure.value,
        controller: controller,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z\d]'))
        ],
        validator: (value) {
          final regExp =
              RegExp(r'(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,24}');
          if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
            return '大文字小文字を含む英数字で入力してください。';
          }
          return null;
        },
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
      ),
      const Text('※大文字小文字を含む英数字8文字以上'),
    ],
  );
}

Widget confirmPasswordFormField(
    TextEditingController passwordController,
    TextEditingController passwordConfirmController,
    ValueNotifier<bool> isObscure) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextFormField(
        obscureText: isObscure.value,
        controller: passwordConfirmController,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z\d]'))
        ],
        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              value != passwordController.text) {
            return '同じパスワードを入力してください。';
          }
          return null;
        },
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
      ),
      const Text('同じパスワードをもう一度入力してください。'),
    ],
  );
}
