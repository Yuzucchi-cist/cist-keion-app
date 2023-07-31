import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widget/home/home_widget.dart';

@RoutePage()
class UnauthenticatedHomePage extends HookConsumerWidget {
  const UnauthenticatedHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return homeWidget(context: context, ref: ref);
  }
}
