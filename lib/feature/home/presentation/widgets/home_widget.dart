import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/router/app_router.dart';
import '../../../reservation/presentation/widgets/reserve_tab_bar_view.dart';

Widget homeWidget(
    {required BuildContext context,
    required WidgetRef ref,
    bool isAuthenticated = false}) {
  return DefaultTabController(
    length: 2,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
        centerTitle: true,
        actions: isAuthenticated
            ? []
            : [
                IconButton(
                  onPressed: () => context.router.push(const AuthRouterRoute()),
                  icon: const Icon(Icons.login),
                ),
              ],
        automaticallyImplyLeading: false,
        bottom: const TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Tab(text: '今週'),
            Tab(text: '来週'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          reserveTabBarView(context, ref, isThisWeek: true, isDisplay: true),
          reserveTabBarView(
            context,
            ref,
            isDisplay: true,
          ),
        ],
      ),
    ),
  );
}
