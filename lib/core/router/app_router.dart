import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../feature/auth/presentation/notifier/auth_notifier.dart';
import '../../feature/auth/presentation/pages/auth_router_page.dart';
import '../../feature/auth/presentation/pages/confirm_email_verify_page.dart';
import '../../feature/auth/presentation/pages/login_page.dart';
import '../../feature/auth/presentation/pages/profile_page.dart';
import '../../feature/auth/presentation/pages/register_page.dart';
import '../../feature/home/presentation/pages/authed_home_page.dart';
import '../../feature/home/presentation/pages/home_page.dart';
import '../../feature/reservation/presentation/pages/cancel_reservation_page.dart';
import '../../feature/reservation/presentation/pages/choose_reserve_table_page.dart';
import '../../feature/reservation/presentation/pages/confirm_reservation_page.dart';
import '../../feature/reservation/presentation/pages/make_reservation_detail_page.dart';
import '../../feature/reservation/presentation/pages/reservetion_router_page.dart';
import '../../feature/root_page.dart';
import '../../feature/suggestion/presentation/pages/confirm_suggestion_page.dart';
import '../../feature/suggestion/presentation/pages/create_suggestion_page.dart';

part 'app_router.gr.dart';

final appRouterProvider = Provider((ref) => AppRouter(ref));

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter implements AutoRouteGuard {
  AppRouter(this.ref);

  final Ref ref;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: HomeRoute.page),
        AutoRoute(
          path: '/authed',
          page: RootRoute.page,
          children: [
            AutoRoute(initial: true, page: AuthedHomeRoute.page),
            AutoRoute(
              path: 'reserve',
              page: ReservationRouterRoute.page,
              children: [
                AutoRoute(initial: true, page: ChooseReserveTableRoute.page),
                AutoRoute(
                    path: 'reserveDetail',
                    page: MakeReservationDetailRoute.page),
                AutoRoute(
                    path: 'confirm_reservation',
                    page: ConfirmReservationRoute.page),
                AutoRoute(
                  path: 'cancel_reservation',
                  page: CancelReservationRoute.page,
                ),
              ],
            ),
            AutoRoute(path: 'suggest', page: CreateSuggestionRoute.page),
            AutoRoute(path: 'profile', page: ProfileRoute.page),
          ],
        ),
        CustomRoute(
          path: '/auth',
          page: AuthRouterRoute.page,
          fullscreenDialog: true,
          children: [
            AutoRoute(initial: true, path: 'login', page: LoginRoute.page),
            AutoRoute(path: 'register', page: RegisterRoute.page),
            AutoRoute(
                path: 'confirm_email', page: ConfirmEmailVerifyRoute.page),
          ],
        ),
      ];

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final routeName = resolver.route.name;

    if ([
      HomeRoute.name,
      AuthRouterRoute.name,
      LoginRoute.name,
      RegisterRoute.name,
      ConfirmEmailVerifyRoute.name,
    ].contains(routeName)) {
      return resolver.next();
    }

    if (ref.watch(authProvider).isAuthenticated) {
      if ([AuthRouterRoute.name].contains(routeName)) {
        resolver.redirect(const RootRoute());
      } else {
        return resolver.next();
      }
    } else {
      resolver.redirect(const RootRoute(children: [AuthedHomeRoute()]));
    }
  }
}
