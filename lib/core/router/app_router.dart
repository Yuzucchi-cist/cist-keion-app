import 'package:auto_route/auto_route.dart';

import '../../feature/auth/presentation/pages/confirm_email_verify_page.dart';
import '../../feature/auth/presentation/pages/login_page.dart';
import '../../feature/auth/presentation/pages/register_page.dart';
import '../../feature/home/presentation/pages/home_page.dart';
import '../../feature/reservation/presentation/pages/choose_reserve_table_page.dart';
import '../../feature/reservation/presentation/pages/confirm_reservation_page.dart';
import '../../feature/reservation/presentation/pages/make_reservation_detail_page.dart';
import '../../feature/reservation/presentation/pages/reservation_complete_page.dart';
import '../../feature/suggestion/presentation/pages/confirm_suggestion_page.dart';
import '../../feature/suggestion/presentation/pages/create_suggestion_page.dart';
import '../../feature/suggestion/presentation/pages/sending_message_complete_pate.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: HomeRoute.page),
        AutoRoute(path: '/login', page: LoginRoute.page),
        AutoRoute(path: '/register', page: RegisterRoute.page),
        AutoRoute(path: '/confirm_email', page: ConfirmEmailVerifyRoute.page),
        AutoRoute(path: '/reserve', page: ChooseReserveTableRoute.page),
        AutoRoute(
            path: '/reserveDetail', page: MakeReservationDetailRoute.page),
        AutoRoute(
            path: '/confirm_reservation', page: ConfirmReservationRoute.page),
        AutoRoute(
            path: '/reservation_complete', page: ReservationCompleteRoute.page),
        AutoRoute(path: '/suggest', page: CreateSuggestionRoute.page),
        AutoRoute(
            path: '/confirm_suggestion', page: ConfirmSuggestionRoute.page),
        AutoRoute(
            path: '/suggestion_complete', page: ConfirmSuggestionRoute.page),
      ];
}
