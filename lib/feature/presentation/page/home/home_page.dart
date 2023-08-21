import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/notifier/auth/auth_notifier.dart';
import '../../widget/home/home_widget.dart';

@RoutePage()
class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(authProvider).value?.isAdmin ?? false;
    return homeWidget(
        context: context, ref: ref, isAuthenticated: true, isAdmin: isAdmin);
  }
}
