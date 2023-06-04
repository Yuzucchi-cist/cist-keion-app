import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/router/app_router.dart';

@RoutePage()
class RootPage extends HookConsumerWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        ReservationRouterRoute(),
        CreateSuggestionRoute(),
        ProfileRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = context.tabsRouter;
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            destinations: const [
              NavigationDestination(label: 'ホーム', icon: Icon(Icons.home)),
              NavigationDestination(
                  label: '予約', icon: Icon(Icons.edit_calendar)),
              NavigationDestination(
                  label: '意見箱', icon: Icon(Icons.settings_suggest)),
              NavigationDestination(label: 'プロフィール', icon: Icon(Icons.person)),
            ],
            onDestinationSelected: tabsRouter.setActiveIndex,
            indicatorColor: ThemeData().primaryColor,
          ),
        );
      },
    );
  }
}
