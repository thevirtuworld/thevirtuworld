// This is a temporary file until build_runner is run
// It provides just enough to make the app compile

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/game_world/presentation/screens/game_world_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import 'app_router.dart';

class AppRouter {
  RouteInformationParser<Object> defaultRouteParser() {
    return const DefaultRouteParser();
  }

  RouterDelegate<Object> delegate() {
    return SimpleRouter(
      routes: {
        '/': (_, __) => const SplashScreen(),
        '/login': (_, __) => const LoginScreen(),
        '/register': (_, __) => const RegisterScreen(),
        '/home': (_, __) => const HomeScreen(),
        '/game-world': (_, __) => const GameWorldScreen(),
        '/profile': (_, __) => const ProfileScreen(),
        '/settings': (_, __) => const SettingsScreen(),
      },
    );
  }
}

class RouterHelper {
  static final pages = {
    SplashScreenRoute.name: (ctx, args) => const SplashScreen(),
    LoginScreenRoute.name: (ctx, args) => const LoginScreen(),
    RegisterScreenRoute.name: (ctx, args) => const RegisterScreen(),
    HomeScreenRoute.name: (ctx, args) => const HomeScreen(),
    GameWorldScreenRoute.name: (ctx, args) => const GameWorldScreen(),
    ProfileScreenRoute.name: (ctx, args) => const ProfileScreen(),
    SettingsScreenRoute.name: (ctx, args) => const SettingsScreen(),
  };
}

// Temporary route classes
class SplashScreenRoute {
  static const name = 'SplashScreenRoute';
  static final page = AutoRoutePage(name: name);
}

class LoginScreenRoute {
  static const name = 'LoginScreenRoute';
  static final page = AutoRoutePage(name: name);
}

class RegisterScreenRoute {
  static const name = 'RegisterScreenRoute';
  static final page = AutoRoutePage(name: name);
}

class HomeScreenRoute {
  static const name = 'HomeScreenRoute';
  static final page = AutoRoutePage(name: name);
}

class GameWorldScreenRoute {
  static const name = 'GameWorldScreenRoute';
  static final page = AutoRoutePage(name: name);
}

class ProfileScreenRoute {
  static const name = 'ProfileScreenRoute';
  static final page = AutoRoutePage(name: name);
}

class SettingsScreenRoute {
  static const name = 'SettingsScreenRoute';
  static final page = AutoRoutePage(name: name);
}

// Simplified route implementation for temporary use
class SimpleRouter extends RouterDelegate<Object> {
  final Map<String, Widget Function(BuildContext, Object?)> routes;
  final String initialRoute;

  SimpleRouter({required this.routes, this.initialRoute = '/'});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [MaterialPage(child: routes[initialRoute]!(context, null))],
      onPopPage: (route, result) => route.didPop(result),
    );
  }

  @override
  Future<bool> popRoute() async => true;

  @override
  Future<void> setNewRoutePath(configuration) async {}

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();
}

class DefaultRouteParser extends RouteInformationParser<Object> {
  const DefaultRouteParser();

  @override
  Future<Object> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    return routeInformation.uri.path;
  }

  @override
  RouteInformation restoreRouteInformation(Object configuration) {
    return RouteInformation(uri: Uri.parse(configuration as String));
  }
}

class AutoRoutePage {
  final String name;
  const AutoRoutePage({required this.name});
}
