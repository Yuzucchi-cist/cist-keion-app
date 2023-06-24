import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/home_widget.dart';

@RoutePage()
class AuthedHomePage extends HookConsumerWidget {
  const AuthedHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return homeWidget(context: context, ref: ref, isAuthenticated: true);
  }
}
