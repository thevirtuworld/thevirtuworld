import 'package:auto_route/auto_route.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/game_world/presentation/screens/game_world_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';

// Use @AutoRouterConfig instead of MaterialAutoRouter
@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashScreenRoute.page, initial: true),
    AutoRoute(page: LoginScreenRoute.page),
    AutoRoute(page: RegisterScreenRoute.page),
    AutoRoute(page: HomeScreenRoute.page),
    AutoRoute(page: GameWorldScreenRoute.page),
    AutoRoute(page: ProfileScreenRoute.page),
    AutoRoute(page: SettingsScreenRoute.page),
  ];
}

// Add this line to generate the router
// run: dart run build_runner build
class $AppRouter {}
