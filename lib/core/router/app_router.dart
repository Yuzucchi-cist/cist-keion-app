import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../feature/presentation/page/page_importer.dart';
import '../../feature/presentation/provider/notifier/auth/auth_notifier.dart';

part 'app_router.gr.dart';

final appRouterProvider = Provider((ref) => AppRouter(ref: ref));

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter implements AutoRouteGuard {
  AppRouter({required this.ref});

  final Ref ref;

  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: UnauthenticatedHomeRoute.page),
        AutoRoute(
          path: '/:id',
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
            AutoRoute(
                path: 'suggest',
                page: SuggestionRouterRoute.page,
                children: [
                  AutoRoute(initial: true, page: CreateSuggestionRoute.page),
                  AutoRoute(
                      path: 'confirm_suggestion',
                      page: ConfirmSuggestionRoute.page),
                ]),
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
        CustomRoute(
          path: '/admin',
          page: AdminRouterRoute.page,
          fullscreenDialog: true,
          children: [
            AutoRoute(initial: true, page: AdminRoute.page),
            AutoRoute(path: 'suggestions', page: SuggestionsRoute.page),
            AutoRoute(
                path: 'suggestion_detail', page: SuggestionDetailRoute.page),
            AutoRoute(path: 'add_members', page: AddMembersRoute.page)
          ],
        ),
      ];

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final routeName = resolver.routeName;

    final unauthenticatedPage = [
      UnauthenticatedHomeRoute.name,
      AuthRouterRoute.name,
      LoginRoute.name,
      RegisterRoute.name,
      ConfirmEmailVerifyRoute.name,
    ];

    final adminPage = [
      AdminRoute.name,
      SuggestionsRoute.name,
      SuggestionDetailRoute.name,
      AddMembersRoute.name,
    ];

    final authState = ref.read(authProvider);
    if (authState.isAuthenticated) {
      if (unauthenticatedPage.contains(routeName)) {
        router
            .push(RootRoute(id: authState.id))
            .then((value) => resolver.next());
        return;
      }
      if ((!authState.isAdmin) && adminPage.contains(routeName)) {
        router
            .push(RootRoute(id: authState.id))
            .then((value) => resolver.next());
        return;
      }
      return resolver.next();
    } else {
      if (unauthenticatedPage.contains(routeName)) {
        return resolver.next();
      }
      resolver.redirect(const UnauthenticatedHomeRoute());
    }
  }
}
