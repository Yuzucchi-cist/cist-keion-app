import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../../feature/auth/presentation/pages/auth_router_page.dart';
import '../../feature/auth/presentation/pages/confirm_email_verify_page.dart';
import '../../feature/auth/presentation/pages/login_page.dart';
import '../../feature/auth/presentation/pages/profile_page.dart';
import '../../feature/auth/presentation/pages/register_page.dart';
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

class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: RootRoute.page,
          children: [
            AutoRoute(initial: true, page: HomeRoute.page),
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
}
