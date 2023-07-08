// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AuthRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthRouterPage(),
      );
    },
    ConfirmEmailVerifyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ConfirmEmailVerifyPage(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginPage(key: args.key),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilePage(),
      );
    },
    RegisterRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterRouteArgs>(
          orElse: () => const RegisterRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegisterPage(key: args.key),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    CancelReservationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CancelReservationPage(),
      );
    },
    ChooseReserveTableRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChooseReserveTablePage(),
      );
    },
    ConfirmReservationRoute.name: (routeData) {
      final args = routeData.argsAs<ConfirmReservationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ConfirmReservationPage(
          key: args.key,
          isAdditionalReservation: args.isAdditionalReservation,
        ),
      );
    },
    MakeReservationDetailRoute.name: (routeData) {
      final args = routeData.argsAs<MakeReservationDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MakeReservationDetailPage(
          key: args.key,
          isAdditionalReservation: args.isAdditionalReservation,
        ),
      );
    },
    ReservationRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ReservationRouterPage(),
      );
    },
    RootRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RootPage(),
      );
    },
    ConfirmSuggestionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ConfirmSuggestionPage(),
      );
    },
    CreateSuggestionRoute.name: (routeData) {
      final args = routeData.argsAs<CreateSuggestionRouteArgs>(
          orElse: () => const CreateSuggestionRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateSuggestionPage(key: args.key),
      );
    },
    SuggestionRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SuggestionRouterPage(),
      );
    },
    AdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AdminPage(),
      );
    },
    AdminRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AdminRouterPage(),
      );
    },
    SuggestionsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SuggestionsPage(),
      );
    },
    SuggestionDetailRoute.name: (routeData) {
      final args = routeData.argsAs<SuggestionDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SuggestionDetailPage(
          args.suggestionId,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [AuthRouterPage]
class AuthRouterRoute extends PageRouteInfo<void> {
  const AuthRouterRoute({List<PageRouteInfo>? children})
      : super(
          AuthRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ConfirmEmailVerifyPage]
class ConfirmEmailVerifyRoute extends PageRouteInfo<void> {
  const ConfirmEmailVerifyRoute({List<PageRouteInfo>? children})
      : super(
          ConfirmEmailVerifyRoute.name,
          initialChildren: children,
        );

  static const String name = 'ConfirmEmailVerifyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<LoginRouteArgs> page = PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          RegisterRoute.name,
          args: RegisterRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<RegisterRouteArgs> page =
      PageInfo<RegisterRouteArgs>(name);
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key}';
  }
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CancelReservationPage]
class CancelReservationRoute extends PageRouteInfo<void> {
  const CancelReservationRoute({List<PageRouteInfo>? children})
      : super(
          CancelReservationRoute.name,
          initialChildren: children,
        );

  static const String name = 'CancelReservationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChooseReserveTablePage]
class ChooseReserveTableRoute extends PageRouteInfo<void> {
  const ChooseReserveTableRoute({List<PageRouteInfo>? children})
      : super(
          ChooseReserveTableRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChooseReserveTableRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ConfirmReservationPage]
class ConfirmReservationRoute
    extends PageRouteInfo<ConfirmReservationRouteArgs> {
  ConfirmReservationRoute({
    Key? key,
    required bool isAdditionalReservation,
    List<PageRouteInfo>? children,
  }) : super(
          ConfirmReservationRoute.name,
          args: ConfirmReservationRouteArgs(
            key: key,
            isAdditionalReservation: isAdditionalReservation,
          ),
          initialChildren: children,
        );

  static const String name = 'ConfirmReservationRoute';

  static const PageInfo<ConfirmReservationRouteArgs> page =
      PageInfo<ConfirmReservationRouteArgs>(name);
}

class ConfirmReservationRouteArgs {
  const ConfirmReservationRouteArgs({
    this.key,
    required this.isAdditionalReservation,
  });

  final Key? key;

  final bool isAdditionalReservation;

  @override
  String toString() {
    return 'ConfirmReservationRouteArgs{key: $key, isAdditionalReservation: $isAdditionalReservation}';
  }
}

/// generated route for
/// [MakeReservationDetailPage]
class MakeReservationDetailRoute
    extends PageRouteInfo<MakeReservationDetailRouteArgs> {
  MakeReservationDetailRoute({
    Key? key,
    required bool isAdditionalReservation,
    List<PageRouteInfo>? children,
  }) : super(
          MakeReservationDetailRoute.name,
          args: MakeReservationDetailRouteArgs(
            key: key,
            isAdditionalReservation: isAdditionalReservation,
          ),
          initialChildren: children,
        );

  static const String name = 'MakeReservationDetailRoute';

  static const PageInfo<MakeReservationDetailRouteArgs> page =
      PageInfo<MakeReservationDetailRouteArgs>(name);
}

class MakeReservationDetailRouteArgs {
  const MakeReservationDetailRouteArgs({
    this.key,
    required this.isAdditionalReservation,
  });

  final Key? key;

  final bool isAdditionalReservation;

  @override
  String toString() {
    return 'MakeReservationDetailRouteArgs{key: $key, isAdditionalReservation: $isAdditionalReservation}';
  }
}

/// generated route for
/// [ReservationRouterPage]
class ReservationRouterRoute extends PageRouteInfo<void> {
  const ReservationRouterRoute({List<PageRouteInfo>? children})
      : super(
          ReservationRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'ReservationRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RootPage]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ConfirmSuggestionPage]
class ConfirmSuggestionRoute extends PageRouteInfo<void> {
  const ConfirmSuggestionRoute({List<PageRouteInfo>? children})
      : super(
          ConfirmSuggestionRoute.name,
          initialChildren: children,
        );

  static const String name = 'ConfirmSuggestionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateSuggestionPage]
class CreateSuggestionRoute extends PageRouteInfo<CreateSuggestionRouteArgs> {
  CreateSuggestionRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CreateSuggestionRoute.name,
          args: CreateSuggestionRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'CreateSuggestionRoute';

  static const PageInfo<CreateSuggestionRouteArgs> page =
      PageInfo<CreateSuggestionRouteArgs>(name);
}

class CreateSuggestionRouteArgs {
  const CreateSuggestionRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'CreateSuggestionRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SuggestionRouterPage]
class SuggestionRouterRoute extends PageRouteInfo<void> {
  const SuggestionRouterRoute({List<PageRouteInfo>? children})
      : super(
          SuggestionRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'SuggestionRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AdminPage]
class AdminRoute extends PageRouteInfo<void> {
  const AdminRoute({List<PageRouteInfo>? children})
      : super(
          AdminRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AdminRouterPage]
class AdminRouterRoute extends PageRouteInfo<void> {
  const AdminRouterRoute({List<PageRouteInfo>? children})
      : super(
          AdminRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdminRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SuggestionsPage]
class SuggestionsRoute extends PageRouteInfo<void> {
  const SuggestionsRoute({List<PageRouteInfo>? children})
      : super(
          SuggestionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SuggestionsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SuggestionDetailPage]
class SuggestionDetailRoute extends PageRouteInfo<SuggestionDetailRouteArgs> {
  SuggestionDetailRoute({
    required String suggestionId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SuggestionDetailRoute.name,
          args: SuggestionDetailRouteArgs(
            suggestionId: suggestionId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SuggestionDetailRoute';

  static const PageInfo<SuggestionDetailRouteArgs> page =
      PageInfo<SuggestionDetailRouteArgs>(name);
}

class SuggestionDetailRouteArgs {
  const SuggestionDetailRouteArgs({
    required this.suggestionId,
    this.key,
  });

  final String suggestionId;

  final Key? key;

  @override
  String toString() {
    return 'SuggestionDetailRouteArgs{suggestionId: $suggestionId, key: $key}';
  }
}
