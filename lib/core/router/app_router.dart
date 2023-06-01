import 'package:auto_route/auto_route.dart';

import '../../feature/auth/presentation/pages/confirm_email_verify_page.dart';
import '../../feature/auth/presentation/pages/login_page.dart';
import '../../feature/auth/presentation/pages/register_page.dart';
import '../../feature/home/presentation/pages/home_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: HomeRoute.page),
        AutoRoute(path: '/login', page: LoginRoute.page),
        AutoRoute(path: '/register', page: RegisterRoute.page),
        AutoRoute(path: '/confirm_email', page: ConfirmEmailVerifyRoute.page),
      ];
}
