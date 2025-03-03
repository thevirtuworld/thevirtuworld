import 'package:flutter/material.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/game_world/presentation/screens/game_world_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';

// A simple custom router implementation that doesn't rely on auto_route
class AppRouter {
  final _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  // Routes mapping
  final Map<String, Widget Function(BuildContext)> _routes = {
    '/': (_) => const SplashScreen(),
    '/login': (_) => const LoginScreen(),
    '/register': (_) => const RegisterScreen(),
    '/home': (_) => const HomeScreen(),
    '/game': (_) => const GameWorldScreen(),
    '/profile': (_) => const ProfileScreen(),
    '/settings': (_) => const SettingsScreen(),
  };

  // Router implementation
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final builder =
        _routes[settings.name] ??
        (_) => const Center(child: Text('Route not found'));

    return MaterialPageRoute(settings: settings, builder: builder);
  }

  // These methods are directly used by MaterialApp.router
  RouterDelegate<Object> delegate() {
    return _AppRouterDelegate(this);
  }

  RouteInformationParser<Object> defaultRouteParser() {
    return _AppRouteParser();
  }
}

// Router delegate implementation
class _AppRouterDelegate extends RouterDelegate<Object> with ChangeNotifier {
  final AppRouter router;

  _AppRouterDelegate(this.router);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: router.navigatorKey,
      onGenerateRoute: router.onGenerateRoute,
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}

  @override
  GlobalKey<NavigatorState>? get navigatorKey => router.navigatorKey;
}

// Route parser implementation
class _AppRouteParser extends RouteInformationParser<Object> {
  @override
  Future<Object> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    return routeInformation.uri.path;
  }

  @override
  RouteInformation? restoreRouteInformation(Object configuration) {
    if (configuration is String) {
      return RouteInformation(uri: Uri.parse(configuration));
    }
    return null;
  }
}
